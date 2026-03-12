# 前沿技术方案库

> 高级开发者参考：创新技术集成与优化模式

## Three.js 集成模式

### 粒子背景系统

```javascript
// 基础粒子系统
import * as THREE from 'three';

class ParticleBackground {
  constructor(container) {
    this.container = container;
    this.scene = new THREE.Scene();
    this.camera = new THREE.PerspectiveCamera(75, container.clientWidth / container.clientHeight, 0.1, 1000);
    this.renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true });

    this.particles = null;
    this.mouse = { x: 0, y: 0 };

    this.init();
    this.animate();
  }

  init() {
    // 设置渲染器
    this.renderer.setSize(this.container.clientWidth, this.container.clientHeight);
    this.renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    this.container.appendChild(this.renderer.domElement);

    // 相机位置
    this.camera.position.z = 5;

    // 创建粒子
    const geometry = new THREE.BufferGeometry();
    const count = 5000;
    const positions = new Float32Array(count * 3);

    for (let i = 0; i < count * 3; i++) {
      positions[i] = (Math.random() - 0.5) * 10;
    }

    geometry.setAttribute('position', new THREE.BufferAttribute(positions, 3));

    const material = new THREE.PointsMaterial({
      size: 0.02,
      color: 0x3b82f6,
      transparent: true,
      opacity: 0.8,
    });

    this.particles = new THREE.Points(geometry, material);
    this.scene.add(this.particles);

    // 鼠标交互
    window.addEventListener('mousemove', (event) => {
      this.mouse.x = (event.clientX / window.innerWidth) * 2 - 1;
      this.mouse.y = -(event.clientY / window.innerHeight) * 2 + 1;
    });

    // 响应式
    window.addEventListener('resize', this.onWindowResize.bind(this));
  }

  animate() {
    requestAnimationFrame(this.animate.bind(this));

    if (this.particles) {
      // 缓慢旋转
      this.particles.rotation.x += 0.001;
      this.particles.rotation.y += 0.002;

      // 鼠标跟随效果
      this.particles.rotation.y += this.mouse.x * 0.0005;
      this.particles.rotation.x += this.mouse.y * 0.0005;
    }

    this.renderer.render(this.scene, this.camera);
  }

  onWindowResize() {
    this.camera.aspect = this.container.clientWidth / this.container.clientHeight;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(this.container.clientWidth, this.container.clientHeight);
  }

  destroy() {
    // 清理资源
    this.renderer.dispose();
    this.container.removeChild(this.renderer.domElement);
  }
}

// 使用示例
// const particleBg = new ParticleBackground(document.getElementById('hero-background'));
```

### 交互式 3D 产品展示

```javascript
// 3D 产品查看器
class ProductViewer3D {
  constructor(modelPath, canvas) {
    this.modelPath = modelPath;
    this.canvas = canvas;
    this.mixer = null;
    this.clock = new THREE.Clock();

    this.init();
  }

  async init() {
    // 初始化场景
    this.scene = new THREE.Scene();
    this.scene.background = new THREE.Color(0xf8fafc);

    this.camera = new THREE.PerspectiveCamera(45, this.canvas.clientWidth / this.canvas.clientHeight, 0.1, 1000);
    this.camera.position.set(0, 1, 5);

    this.renderer = new THREE.WebGLRenderer({
      canvas: this.canvas,
      antialias: true,
      alpha: true
    });
    this.renderer.setSize(this.canvas.clientWidth, this.canvas.clientHeight);
    this.renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    this.renderer.shadowMap.enabled = true;

    // 灯光
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.6);
    this.scene.add(ambientLight);

    const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8);
    directionalLight.position.set(5, 10, 7);
    directionalLight.castShadow = true;
    this.scene.add(directionalLight);

    // 加载模型
    const loader = new THREE.GLTFLoader();
    const gltf = await loader.loadAsync(this.modelPath);

    this.model = gltf.scene;
    this.model.scale.set(1, 1, 1);
    this.model.position.y = -1;
    this.scene.add(this.model);

    // 动画
    if (gltf.animations && gltf.animations.length) {
      this.mixer = new THREE.AnimationMixer(this.model);
      gltf.animations.forEach(clip => {
        this.mixer.clipAction(clip).play();
      });
    }

    // 轨道控制
    this.controls = new THREE.OrbitControls(this.camera, this.renderer.domElement);
    this.controls.enableDamping = true;
    this.controls.dampingFactor = 0.05;
    this.controls.minDistance = 2;
    this.controls.maxDistance = 10;

    // 响应式
    window.addEventListener('resize', this.onWindowResize.bind(this));

    this.animate();
  }

  animate() {
    requestAnimationFrame(this.animate.bind(this));

    const delta = this.clock.getDelta();
    if (this.mixer) this.mixer.update(delta);
    if (this.controls) this.controls.update();

    this.renderer.render(this.scene, this.camera);
  }

  onWindowResize() {
    this.camera.aspect = this.canvas.clientWidth / this.canvas.clientHeight;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(this.canvas.clientWidth, this.canvas.clientHeight);
  }

  changeColor(colorHex) {
    // 遍历模型修改材质颜色
    this.model.traverse((child) => {
      if (child.isMesh && child.material) {
        child.material.color.setHex(colorHex);
      }
    });
  }
}
```

## WebGL 性能优化

### 渲染优化技巧

```javascript
// 1. 实例化渲染（大量相同物体）
const instanceCount = 1000;
const geometry = new THREE.BoxGeometry(1, 1, 1);
const material = new THREE.MeshBasicMaterial({ color: 0x3b82f6 });
const mesh = new THREE.InstancedMesh(geometry, material, instanceCount);

const matrix = new THREE.Matrix4();
for (let i = 0; i < instanceCount; i++) {
  matrix.setPosition(
    Math.random() * 100 - 50,
    Math.random() * 100 - 50,
    Math.random() * 100 - 50
  );
  mesh.setMatrixAt(i, matrix);
}
mesh.instanceMatrix.needsUpdate = true;

// 2. 细节层次（LOD）
const lod = new THREE.LOD();
const highDetail = new THREE.Mesh(geometry, material);
const lowDetail = new THREE.Mesh(geometry, material);

lod.addLevel(highDetail, 0);    // 0-50 单位距离使用高细节
lod.addLevel(lowDetail, 50);    // 50+ 单位距离使用低细节

// 3. 视锥体剔除
const frustum = new THREE.Frustum();
const cameraViewProjectionMatrix = new THREE.Matrix4();
cameraViewProjectionMatrix.multiplyMatrices(
  this.camera.projectionMatrix,
  this.camera.matrixWorldInverse
);
frustum.setFromProjectionMatrix(cameraViewProjectionMatrix);

if (frustum.intersectsObject(mesh)) {
  // 在视锥体内，渲染
}
```

### 内存管理

```javascript
// 资源清理
function disposeObject3D(object) {
  if (!object) return;

  object.traverse((child) => {
    if (child.isMesh) {
      if (child.geometry) child.geometry.dispose();
      if (child.material) {
        if (Array.isArray(child.material)) {
          child.material.forEach(material => disposeMaterial(material));
        } else {
          disposeMaterial(child.material);
        }
      }
    }

    if (child.isTexture) child.dispose();
    if (child.isRenderTarget) child.dispose();
  });
}

function disposeMaterial(material) {
  material.dispose();
  Object.keys(material).forEach(key => {
    const value = material[key];
    if (value && typeof value === 'object' && 'dispose' in value) {
      value.dispose();
    }
  });
}
```

## 高级 CSS 模式

### 视差滚动库

```css
/* 纯 CSS 视差 */
.parallax-container {
  height: 100vh;
  overflow-x: hidden;
  overflow-y: auto;
  perspective: 1px;
  transform-style: preserve-3d;
}

.parallax-layer {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
}

.parallax-layer-back {
  transform: translateZ(-1px) scale(2);
}

.parallax-layer-base {
  transform: translateZ(0);
}

.parallax-layer-front {
  transform: translateZ(0.5px) scale(0.5);
}
```

### 着色器效果集成

```javascript
// 自定义着色器材质
const vertexShader = `
  varying vec2 vUv;
  varying vec3 vPosition;

  void main() {
    vUv = uv;
    vPosition = position;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
  }
`;

const fragmentShader = `
  varying vec2 vUv;
  varying vec3 vPosition;

  uniform float uTime;
  uniform vec3 uColor1;
  uniform vec3 uColor2;

  void main() {
    // 渐变背景
    vec3 gradient = mix(uColor1, uColor2, vUv.y);

    // 波纹效果
    float wave = sin(vPosition.x * 10.0 + uTime) * 0.5 + 0.5;
    vec3 finalColor = mix(gradient, vec3(1.0), wave * 0.2);

    gl_FragColor = vec4(finalColor, 1.0);
  }
`;

const shaderMaterial = new THREE.ShaderMaterial({
  vertexShader,
  fragmentShader,
  uniforms: {
    uTime: { value: 0 },
    uColor1: { value: new THREE.Color(0x3b82f6) },
    uColor2: { value: new THREE.Color(0x8b5cf6) }
  }
});

// 动画循环中更新时间
function animate() {
  shaderMaterial.uniforms.uTime.value = performance.now() * 0.001;
}
```

## 实时通信模式

### WebSocket 实时仪表板

```javascript
class RealtimeDashboard {
  constructor(endpoint) {
    this.endpoint = endpoint;
    this.ws = null;
    this.reconnectAttempts = 0;
    this.maxReconnectAttempts = 5;
    this.reconnectDelay = 1000;

    this.metrics = {
      cpu: 0,
      memory: 0,
      requests: 0,
      errors: 0
    };

    this.charts = {};
    this.init();
  }

  init() {
    this.connect();
    this.initCharts();
  }

  connect() {
    this.ws = new WebSocket(this.endpoint);

    this.ws.onopen = () => {
      console.log('WebSocket 连接已建立');
      this.reconnectAttempts = 0;
      this.subscribeToMetrics();
    };

    this.ws.onmessage = (event) => {
      const data = JSON.parse(event.data);
      this.updateMetrics(data);
      this.updateCharts(data);
    };

    this.ws.onclose = () => {
      console.log('WebSocket 连接关闭');
      this.attemptReconnect();
    };

    this.ws.onerror = (error) => {
      console.error('WebSocket 错误:', error);
    };
  }

  subscribeToMetrics() {
    const message = {
      type: 'subscribe',
      channels: ['cpu', 'memory', 'requests', 'errors']
    };
    this.ws.send(JSON.stringify(message));
  }

  updateMetrics(data) {
    Object.keys(data).forEach(key => {
      if (this.metrics.hasOwnProperty(key)) {
        this.metrics[key] = data[key];
        this.updateMetricDisplay(key, data[key]);
      }
    });
  }

  updateMetricDisplay(metric, value) {
    const element = document.querySelector(`[data-metric="${metric}"]`);
    if (element) {
      element.textContent = this.formatValue(metric, value);
      this.animateValueChange(element, value);
    }
  }

  formatValue(metric, value) {
    switch (metric) {
      case 'cpu':
        return `${value.toFixed(1)}%`;
      case 'memory':
        return `${(value / 1024 / 1024).toFixed(1)} MB`;
      case 'requests':
        return `${value}/s`;
      case 'errors':
        return value;
      default:
        return value;
    }
  }

  animateValueChange(element, newValue) {
    element.classList.add('metric-updated');
    setTimeout(() => {
      element.classList.remove('metric-updated');
    }, 500);
  }

  initCharts() {
    // 初始化图表库（如 Chart.js、ECharts）
    Object.keys(this.metrics).forEach(metric => {
      this.charts[metric] = this.createChart(metric);
    });
  }

  updateCharts(data) {
    Object.keys(data).forEach(metric => {
      if (this.charts[metric]) {
        this.charts[metric].update(data[metric]);
      }
    });
  }

  attemptReconnect() {
    if (this.reconnectAttempts < this.maxReconnectAttempts) {
      this.reconnectAttempts++;
      console.log(`尝试重新连接 (${this.reconnectAttempts}/${this.maxReconnectAttempts})...`);

      setTimeout(() => {
        this.connect();
      }, this.reconnectDelay * Math.pow(1.5, this.reconnectAttempts - 1));
    } else {
      console.error('达到最大重连次数，停止尝试');
    }
  }

  disconnect() {
    if (this.ws) {
      this.ws.close();
    }
  }
}
```

## 边缘计算模式

### Service Worker 离线优先

```javascript
// service-worker.js
const CACHE_NAME = 'premium-v1';
const OFFLINE_URL = '/offline.html';

const PRECACHE_URLS = [
  '/',
  '/styles/main.css',
  '/scripts/main.js',
  '/images/logo.svg',
  OFFLINE_URL
];

// 安装阶段：预缓存关键资源
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(PRECACHE_URLS))
      .then(() => self.skipWaiting())
  );
});

// 激活阶段：清理旧缓存
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => self.clients.claim())
  );
});

// 获取策略：网络优先，回退缓存
self.addEventListener('fetch', event => {
  // 跳过非 GET 请求和浏览器扩展
  if (event.request.method !== 'GET' ||
      event.request.url.startsWith('chrome-extension://')) {
    return;
  }

  event.respondWith(
    fetch(event.request)
      .then(response => {
        // 网络请求成功，更新缓存
        const responseClone = response.clone();
        caches.open(CACHE_NAME)
          .then(cache => cache.put(event.request, responseClone));
        return response;
      })
      .catch(() => {
        // 网络失败，尝试从缓存获取
        return caches.match(event.request)
          .then(cachedResponse => {
            if (cachedResponse) {
              return cachedResponse;
            }

            // 如果请求 HTML 页面但缓存中没有，返回离线页面
            if (event.request.headers.get('accept').includes('text/html')) {
              return caches.match(OFFLINE_URL);
            }

            // 其他资源返回空响应
            return new Response('', {
              status: 408,
              statusText: 'Network error'
            });
          });
      })
  );
});
```

## 性能监控集成

### Web Vitals 监控

```javascript
import { getCLS, getFID, getLCP, getFCP, getTTFB } from 'web-vitals';

class PerformanceMonitor {
  constructor() {
    this.metrics = {};
    this.reportEndpoint = '/api/performance';
    this.thresholds = {
      CLS: 0.1,    // Cumulative Layout Shift
      FID: 100,    // First Input Delay (ms)
      LCP: 2500,   // Largest Contentful Paint (ms)
      FCP: 1800,   // First Contentful Paint (ms)
      TTFB: 800    // Time to First Byte (ms)
    };

    this.init();
  }

  init() {
    // 收集 Web Vitals
    getCLS(this.reportMetric.bind(this, 'CLS'));
    getFID(this.reportMetric.bind(this, 'FID'));
    getLCP(this.reportMetric.bind(this, 'LCP'));
    getFCP(this.reportMetric.bind(this, 'FCP'));
    getTTFB(this.reportMetric.bind(this, 'TTFB'));

    // 自定义性能指标
    this.monitorCustomMetrics();

    // 错误监控
    window.addEventListener('error', this.reportError.bind(this));
    window.addEventListener('unhandledrejection', this.reportPromiseError.bind(this));
  }

  reportMetric(metricName, metric) {
    this.metrics[metricName] = {
      value: metric.value,
      rating: this.getRating(metricName, metric.value),
      delta: metric.delta,
      id: metric.id,
      entries: metric.entries
    };

    // 发送到分析服务
    this.sendToAnalytics(metricName, this.metrics[metricName]);

    // 控制台警告（开发环境）
    if (process.env.NODE_ENV === 'development' && this.metrics[metricName].rating === 'poor') {
      console.warn(`性能警告: ${metricName} = ${metric.value} (${this.metrics[metricName].rating})`);
    }
  }

  getRating(metricName, value) {
    const threshold = this.thresholds[metricName];
    if (!threshold) return 'unknown';

    // 特殊处理 CLS（越小越好）
    if (metricName === 'CLS') {
      if (value <= 0.1) return 'good';
      if (value <= 0.25) return 'needs-improvement';
      return 'poor';
    }

    // 其他指标（越小越好）
    if (value <= threshold * 0.75) return 'good';
    if (value <= threshold) return 'needs-improvement';
    return 'poor';
  }

  monitorCustomMetrics() {
    // 资源加载时间
    const resources = performance.getEntriesByType('resource');
    this.metrics.resourceTiming = resources.map(resource => ({
      name: resource.name,
      duration: resource.duration,
      transferSize: resource.transferSize,
      initiatorType: resource.initiatorType
    }));

    // 长任务监控
    const observer = new PerformanceObserver((list) => {
      const longTasks = list.getEntries();
      this.metrics.longTasks = longTasks.map(task => ({
        duration: task.duration,
        startTime: task.startTime,
        name: task.name
      }));
    });
    observer.observe({ entryTypes: ['longtask'] });

    // 布局偏移监控
    const layoutShiftObserver = new PerformanceObserver((list) => {
      const shifts = list.getEntries();
      this.metrics.layoutShifts = shifts.map(shift => ({
        value: shift.value,
        hadRecentInput: shift.hadRecentInput,
        sources: shift.sources
      }));
    });
    layoutShiftObserver.observe({ entryTypes: ['layout-shift'] });
  }

  reportError(event) {
    const errorData = {
      message: event.message,
      filename: event.filename,
      lineno: event.lineno,
      colno: event.colno,
      error: event.error?.stack,
      timestamp: new Date().toISOString(),
      userAgent: navigator.userAgent,
      url: window.location.href
    };

    this.sendToErrorTracking(errorData);
  }

  reportPromiseError(event) {
    const errorData = {
      message: event.reason?.message || 'Unhandled Promise Rejection',
      stack: event.reason?.stack,
      timestamp: new Date().toISOString()
    };

    this.sendToErrorTracking(errorData);
  }

  sendToAnalytics(metricName, data) {
    // 发送到分析后端
    navigator.sendBeacon(this.reportEndpoint, JSON.stringify({
      type: 'performance',
      metric: metricName,
      data,
      sessionId: this.getSessionId(),
      page: window.location.pathname
    }));
  }

  sendToErrorTracking(data) {
    navigator.sendBeacon('/api/errors', JSON.stringify(data));
  }

  getSessionId() {
    let sessionId = sessionStorage.getItem('performanceSessionId');
    if (!sessionId) {
      sessionId = 'session_' + Math.random().toString(36).substr(2, 9);
      sessionStorage.setItem('performanceSessionId', sessionId);
    }
    return sessionId;
  }

  getReport() {
    return {
      timestamp: new Date().toISOString(),
      url: window.location.href,
      metrics: this.metrics,
      summary: this.getSummary()
    };
  }

  getSummary() {
    const summary = {};
    Object.keys(this.metrics).forEach(key => {
      if (this.metrics[key] && typeof this.metrics[key] === 'object' && 'rating' in this.metrics[key]) {
        summary[key] = this.metrics[key].rating;
      }
    });
    return summary;
  }
}

// 使用示例
// const perfMonitor = new PerformanceMonitor();
```

## 部署与运维

### 渐进式增强策略

1. **核心功能优先** - 确保基础功能在不支持 JavaScript 时仍可用
2. **按需加载** - 非关键功能延迟加载
3. **优雅降级** - 现代特性不可用时提供备选方案
4. **特性检测** - 使用 `if (featureSupported) { }` 而不是用户代理检测

### A/B 测试集成

```javascript
class ExperimentManager {
  constructor() {
    this.experiments = {};
    this.variantStorageKey = 'experiment_variants';
    this.loadVariants();
  }

  defineExperiment(name, variants, options = {}) {
    this.experiments[name] = {
      variants,
      traffic: options.traffic || 1.0,
      isActive: options.isActive || true,
      audience: options.audience || 'all'
    };

    return this.getVariant(name);
  }

  getVariant(experimentName) {
    if (!this.experiments[experimentName] || !this.experiments[experimentName].isActive) {
      return null;
    }

    // 检查是否已有分配的变体
    if (this.assignedVariants[experimentName]) {
      return this.assignedVariants[experimentName];
    }

    // 检查受众条件
    if (!this.isInAudience(experimentName)) {
      return null;
    }

    // 流量分配
    if (Math.random() > this.experiments[experimentName].traffic) {
      return null;
    }

    // 随机分配变体
    const variants = this.experiments[experimentName].variants;
    const variantIndex = Math.floor(Math.random() * variants.length);
    const variant = variants[variantIndex];

    this.assignedVariants[experimentName] = variant;
    this.saveVariants();

    this.trackAssignment(experimentName, variant);

    return variant;
  }

  isInAudience(experimentName) {
    const audience = this.experiments[experimentName].audience;

    if (audience === 'all') return true;
    if (typeof audience === 'function') return audience();

    // 基于用户属性的受众
    if (audience.property) {
      const userValue = this.getUserProperty(audience.property);
      return audience.values.includes(userValue);
    }

    return true;
  }

  trackAssignment(experimentName, variant) {
    // 发送到分析平台
    window.dataLayer = window.dataLayer || [];
    window.dataLayer.push({
      event: 'experiment_assignment',
      experiment_name: experimentName,
      variant,
      timestamp: new Date().toISOString()
    });
  }

  trackConversion(experimentName, conversionName, value = 1) {
    const variant = this.assignedVariants[experimentName];
    if (!variant) return;

    // 发送转化事件
    window.dataLayer = window.dataLayer || [];
    window.dataLayer.push({
      event: 'experiment_conversion',
      experiment_name: experimentName,
      variant,
      conversion_name: conversionName,
      value,
      timestamp: new Date().toISOString()
    });
  }

  loadVariants() {
    try {
      this.assignedVariants = JSON.parse(localStorage.getItem(this.variantStorageKey)) || {};
    } catch {
      this.assignedVariants = {};
    }
  }

  saveVariants() {
    localStorage.setItem(this.variantStorageKey, JSON.stringify(this.assignedVariants));
  }

  getUserProperty(property) {
    // 从用户上下文中获取属性
    const userContext = window.userContext || {};
    return userContext[property];
  }
}

// 使用示例
// const experiments = new ExperimentManager();
// const buttonColor = experiments.defineExperiment('button_color', ['blue', 'green', 'purple'], { traffic: 0.5 });
// if (buttonColor === 'green') {
//   document.querySelector('.cta-button').style.backgroundColor = '#10b981';
// }
```

---

*最后更新：2026-03-12 | 持续更新前沿技术方案*