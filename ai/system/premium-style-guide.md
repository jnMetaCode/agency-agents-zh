# 高端设计模式指南

> 高级开发者参考：打造有质感的 Web 体验

## 设计哲学

### 工匠精神
- **每一个像素都该是有意为之的** - 没有偶然的间距，没有随意的颜色
- **流畅的动画和微交互不是锦上添花，而是必需品** - 动画是用户体验的语言
- **性能和美感必须并存** - 慢速的华丽等于失败
- **当创新能提升体验时，大胆打破常规** - 在理解规则的基础上创新

## 视觉层次

### 字体层级系统

```css
/* 基础字体变量 */
:root {
  --font-size-xs: 0.75rem;   /* 12px */
  --font-size-sm: 0.875rem;  /* 14px */
  --font-size-base: 1rem;    /* 16px */
  --font-size-lg: 1.125rem;  /* 18px */
  --font-size-xl: 1.25rem;   /* 20px */
  --font-size-2xl: 1.5rem;   /* 24px */
  --font-size-3xl: 1.875rem; /* 30px */
  --font-size-4xl: 2.25rem;  /* 36px */
  --font-size-5xl: 3rem;     /* 48px */

  --font-weight-normal: 400;
  --font-weight-medium: 500;
  --font-weight-semibold: 600;
  --font-weight-bold: 700;
}

/* 使用示例 */
.hero-title {
  font-size: var(--font-size-5xl);
  font-weight: var(--font-weight-bold);
  line-height: 1.1;
}

.section-heading {
  font-size: var(--font-size-3xl);
  font-weight: var(--font-weight-semibold);
  line-height: 1.2;
}
```

### 间距系统 (8px 基准)

```css
:root {
  --space-1: 0.25rem;  /* 4px */
  --space-2: 0.5rem;   /* 8px */
  --space-3: 0.75rem;  /* 12px */
  --space-4: 1rem;     /* 16px */
  --space-6: 1.5rem;   /* 24px */
  --space-8: 2rem;     /* 32px */
  --space-12: 3rem;    /* 48px */
  --space-16: 4rem;    /* 64px */
  --space-24: 6rem;    /* 96px */
}
```

## 颜色与主题

### 强制要求：三主题系统
**每个站点都必须实现亮色/暗色/跟随系统的主题切换**

```css
/* 主题变量定义 */
:root {
  /* 亮色主题 */
  --color-background: #ffffff;
  --color-foreground: #0a0a0a;
  --color-primary: #3b82f6;
  --color-secondary: #6b7280;
  --color-accent: #8b5cf6;
  --color-muted: #f3f4f6;
  --color-border: #e5e7eb;
}

@media (prefers-color-scheme: dark) {
  :root {
    /* 暗色主题 */
    --color-background: #0a0a0a;
    --color-foreground: #fafafa;
    --color-primary: #60a5fa;
    --color-secondary: #9ca3af;
    --color-accent: #a78bfa;
    --color-muted: #1f2937;
    --color-border: #374151;
  }
}

/* 主题切换类 */
.theme-light {
  --color-background: #ffffff;
  --color-foreground: #0a0a0a;
  /* ... 其他变量 */
}

.theme-dark {
  --color-background: #0a0a0a;
  --color-foreground: #fafafa;
  /* ... 其他变量 */
}
```

## 高端效果模式

### 毛玻璃效果 (Glassmorphism)

```css
.luxury-glass {
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(30px) saturate(200%);
  -webkit-backdrop-filter: blur(30px) saturate(200%);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.1),
    inset 0 1px 0 rgba(255, 255, 255, 0.1);
}

/* 暗色主题适配 */
.dark .luxury-glass {
  background: rgba(0, 0, 0, 0.2);
  border: 1px solid rgba(255, 255, 255, 0.05);
}
```

### 磁吸效果 (Magnetic Interaction)

```css
.magnetic-element {
  transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.magnetic-element:hover {
  transform: scale(1.05) translateY(-2px);
}

/* 高级版本：光标追踪 */
.magnetic-track {
  position: relative;
  overflow: hidden;
}

.magnetic-track::after {
  content: '';
  position: absolute;
  width: 200px;
  height: 200px;
  background: radial-gradient(circle, rgba(59, 130, 246, 0.1) 0%, transparent 70%);
  top: var(--mouse-y, 50%);
  left: var(--mouse-x, 50%);
  transform: translate(-50%, -50%);
  pointer-events: none;
  opacity: 0;
  transition: opacity 0.3s;
}

.magnetic-track:hover::after {
  opacity: 1;
}
```

### 流体形变动画

```css
@keyframes fluid-morph {
  0%, 100% {
    border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%;
  }
  50% {
    border-radius: 30% 60% 70% 40% / 50% 60% 30% 60%;
  }
}

.fluid-shape {
  animation: fluid-morph 8s ease-in-out infinite;
  background: linear-gradient(45deg, var(--color-primary), var(--color-accent));
}
```

## 动画曲线库

### 标准缓动函数

```css
:root {
  --ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
  --ease-out: cubic-bezier(0, 0, 0.2, 1);
  --ease-in: cubic-bezier(0.4, 0, 1, 1);
  --ease-spring: cubic-bezier(0.16, 1, 0.3, 1); /* 弹簧感 */
  --ease-bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55); /* 弹跳感 */
}

/* 使用示例 */
.smooth-transition {
  transition: all 0.3s var(--ease-in-out);
}

.springy-transition {
  transition: all 0.5s var(--ease-spring);
}
```

### 视差滚动效果

```css
.parallax-layer {
  transform-style: preserve-3d;
}

.parallax-background {
  transform: translateZ(-10px) scale(2);
}

.parallax-foreground {
  transform: translateZ(5px) scale(0.95);
}
```

## 响应式设计策略

### 移动端优先断点

```css
/* 基础移动端样式 */
.container {
  padding: var(--space-4);
}

/* 平板端 */
@media (min-width: 768px) {
  .container {
    padding: var(--space-8);
    max-width: 768px;
    margin: 0 auto;
  }
}

/* 桌面端 */
@media (min-width: 1024px) {
  .container {
    max-width: 1024px;
  }
}

/* 大桌面端 */
@media (min-width: 1280px) {
  .container {
    max-width: 1280px;
  }
}
```

### 响应式字体

```css
:root {
  --fluid-min-width: 320;
  --fluid-max-width: 1280;
  --fluid-min-size: 16;
  --fluid-max-size: 20;
}

html {
  font-size: clamp(
    calc(var(--fluid-min-size) * 1px),
    calc(var(--fluid-min-size) * 1px + (var(--fluid-max-size) - var(--fluid-min-size)) * ((100vw - var(--fluid-min-width) * 1px) / (var(--fluid-max-width) - var(--fluid-min-width)))),
    calc(var(--fluid-max-size) * 1px)
  );
}
```

## 性能优化

### 动画性能提示
1. **使用 `transform` 和 `opacity`** - 这两个属性不会触发重排
2. **避免动画期间改变布局属性** - 如 `width`, `height`, `margin`, `padding`
3. **使用 `will-change` 谨慎** - 只在确实需要时使用
4. **限制动画数量** - 同时运行过多动画会降低性能

### 图片优化
1. **使用 WebP/AVIF 格式** - 现代浏览器支持
2. **实现懒加载** - `loading="lazy"` 属性
3. **响应式图片** - `srcset` 和 `sizes` 属性
4. **CDN 优化** - 图片压缩和缓存

## 无障碍设计

### WCAG 2.1 AA 合规检查表
- **颜色对比度** - 文本与背景至少 4.5:1
- **键盘导航** - 所有交互元素可通过键盘访问
- **屏幕阅读器** - 语义化 HTML 和 ARIA 标签
- **焦点指示器** - 清晰的焦点状态
- **动画控制** - 尊重 `prefers-reduced-motion`

## 质量指标

### 设计验收标准
- ✅ 三主题切换流畅无闪烁
- ✅ 所有动画运行在 60fps
- ✅ 移动端触控目标至少 44×44px
- ✅ 颜色对比度通过 WCAG 2.1 AA
- ✅ 响应式布局在所有断点下可用
- ✅ 加载时间 < 1.5 秒（Lighthouse 评分）

---

*最后更新：2026-03-12 | 适用：所有高端 Web 项目*