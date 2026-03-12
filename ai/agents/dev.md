# 开发智能体参考文档

> 高级开发者参考：完整的技术实现方法、代码模式和质量标准

## 概述

本文档为 Agency 智能体系统中的开发相关智能体提供技术参考，包括工程实现模式、质量标准和最佳实践。

## 核心开发原则

### 1. 质量优先
- **代码即文档**：清晰的命名、适当的注释、完整的类型定义
- **测试驱动**：关键路径必有测试，覆盖率 > 80%
- **性能意识**：从第一行代码就考虑性能影响
- **安全默认**：所有输入都是不可信的，所有输出都是受控的

### 2. 用户体验驱动
- **性能指标**：LCP < 2.5s, FID < 100ms, CLS < 0.1
- **无障碍访问**：WCAG 2.1 AA 合规
- **响应式设计**：移动端优先，渐进增强
- **交互流畅**：60fps 动画，微交互增强

### 3. 可维护性
- **关注点分离**：清晰的模块边界，单一职责
- **配置化**：硬编码最小化，环境变量驱动
- **向后兼容**：API 版本管理，平滑升级
- **监控就绪**：内置指标收集，错误追踪

## 技术栈规范

### 前端开发
```yaml
核心框架:
  - React 18+ (函数组件 + Hooks)
  - Vue 3 (组合式 API)
  - Svelte 4+

状态管理:
  - React: Zustand/Recoil (Redux 仅大型应用)
  - Vue: Pinia
  - 简单场景: Context/Props

样式方案:
  - 首选: Tailwind CSS + CSS 变量
  - 备选: CSS Modules/Styled Components
  - 禁止: 全局 CSS 污染

组件库:
  - FluxUI (优先)
  - Ant Design (企业级)
  - Headless UI (完全自定义)
```

### 后端开发
```yaml
API 设计:
  - RESTful (资源导向)
  - GraphQL (复杂数据需求)
  - 版本: URL 路径版本 (v1/, v2/)

数据层:
  - ORM: Laravel Eloquent/TypeORM/Prisma
  - 查询: 参数化查询，防 SQL 注入
  - 缓存: Redis 热点数据

认证授权:
  - JWT (无状态 API)
  - OAuth 2.0 (第三方集成)
  - 角色权限: RBAC 模型
```

### 数据库设计
```sql
-- 命名规范
表名: 复数小写蛇形 (users, order_items)
列名: 小写蛇形 (created_at, user_id)
主键: id (BIGINT UNSIGNED AUTO_INCREMENT)
外键: {table}_id (与引用表主键类型一致)

-- 索引策略
查询频繁列: 单独索引
复合查询: 复合索引 (注意顺序)
外键列: 自动索引
文本搜索: 全文索引
```

## 代码质量标准

### 代码审查清单
- [ ] 无拼写错误 (变量名、注释、字符串)
- [ ] 无未使用的导入/变量
- [ ] 错误处理完备 (try-catch, 空值检查)
- [ ] 类型安全 (TypeScript/类型注解)
- [ ] 性能影响评估 (循环复杂度、内存使用)
- [ ] 安全审查 (XSS, SQL 注入, CSRF)
- [ ] 测试覆盖 (新增代码有对应测试)
- [ ] 文档更新 (API 文档、README)

### 复杂度控制
```javascript
// 不好: 函数过长，职责过多
function processUserDataAndSendEmailAndUpdateDB(user) { ... }

// 好: 单一职责，组合使用
function validateUserData(user) { ... }
function sendWelcomeEmail(user) { ... }
function saveUserToDatabase(user) { ... }

// 主函数协调
async function registerUser(user) {
  validateUserData(user);
  await saveUserToDatabase(user);
  await sendWelcomeEmail(user);
}
```

### 错误处理模式
```typescript
// 1. 预期错误 (业务逻辑)
class ValidationError extends Error {
  constructor(message: string, public field?: string) {
    super(message);
    this.name = 'ValidationError';
  }
}

// 2. 操作错误 (外部依赖)
class DatabaseConnectionError extends Error {
  constructor(originalError: Error) {
    super(`数据库连接失败: ${originalError.message}`);
    this.name = 'DatabaseConnectionError';
  }
}

// 3. 统一错误响应
interface ApiErrorResponse {
  error: string;
  message: string;
  code?: string;
  details?: Record<string, any>;
  timestamp: string;
}

function createErrorResponse(error: Error): ApiErrorResponse {
  return {
    error: error.name,
    message: error.message,
    code: 'code' in error ? (error as any).code : undefined,
    details: 'details' in error ? (error as any).details : undefined,
    timestamp: new Date().toISOString()
  };
}
```

## 性能优化模式

### 前端性能
```javascript
// 1. 图片优化
// 使用 WebP/AVIF，响应式 srcset，懒加载
<img
  srcset="image-320w.webp 320w, image-640w.webp 640w"
  sizes="(max-width: 600px) 320px, 640px"
  src="image-640w.webp"
  loading="lazy"
  alt="描述"
>

// 2. 代码分割
const HeavyComponent = React.lazy(() => import('./HeavyComponent'));

// 3. 虚拟列表 (大量数据)
import { FixedSizeList } from 'react-window';

// 4. Web Workers (CPU 密集型任务)
const worker = new Worker('./worker.js');
worker.postMessage(data);
worker.onmessage = (event) => handleResult(event.data);
```

### 后端性能
```typescript
// 1. 数据库查询优化
// 避免 N+1 查询
const users = await User.findAll({
  include: [{
    model: Post,
    limit: 10  // 限制关联数据
  }],
  limit: 50,
  order: [['created_at', 'DESC']]
});

// 2. 缓存策略
const cacheKey = `user:${userId}:profile`;
const cached = await redis.get(cacheKey);
if (cached) return JSON.parse(cached);

const user = await fetchUserFromDB(userId);
await redis.setex(cacheKey, 3600, JSON.stringify(user)); // 1小时过期
return user;

// 3. 批处理
async function batchProcessItems(items: Item[], batchSize = 100) {
  const results = [];
  for (let i = 0; i < items.length; i += batchSize) {
    const batch = items.slice(i, i + batchSize);
    const batchResults = await processBatch(batch);
    results.push(...batchResults);
  }
  return results;
}
```

## 安全最佳实践

### 输入验证
```typescript
import { z } from 'zod';

// 使用 Schema 验证
const UserSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8).regex(/[A-Z]/).regex(/[a-z]/).regex(/[0-9]/),
  age: z.number().min(18).max(120),
  interests: z.array(z.string()).max(10)
});

// 严格验证
try {
  const validData = UserSchema.parse(userInput);
} catch (error) {
  throw new ValidationError('输入数据验证失败', error);
}
```

### 输出编码
```javascript
// 防止 XSS
function sanitizeHtml(input) {
  const div = document.createElement('div');
  div.textContent = input; // 自动编码
  return div.innerHTML;
}

// 或者使用库
import DOMPurify from 'dompurify';
const clean = DOMPurify.sanitize(dirtyHtml);
```

### API 安全
```typescript
// 1. 速率限制
import rateLimit from 'express-rate-limit';

const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15分钟
  max: 100, // 每个 IP 限制 100 次请求
  message: '请求过于频繁，请稍后再试'
});

// 2. CORS 配置
app.use(cors({
  origin: process.env.ALLOWED_ORIGINS?.split(',') || [],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH']
}));

// 3. 安全头
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'", "'unsafe-inline'"],
      imgSrc: ["'self'", "data:", "https:"]
    }
  }
}));
```

## 测试策略

### 测试金字塔
```
        E2E 测试 (10%)
           /   \
          /     \
集成测试 (20%)   |
          \     /
           \   /
        单元测试 (70%)
```

### 单元测试示例
```typescript
// 纯函数测试
describe('calculateDiscount', () => {
  it('应该为会员提供20%折扣', () => {
    const result = calculateDiscount(100, true);
    expect(result).toBe(80);
  });

  it('非会员无折扣', () => {
    const result = calculateDiscount(100, false);
    expect(result).toBe(100);
  });

  it('处理零金额', () => {
    const result = calculateDiscount(0, true);
    expect(result).toBe(0);
  });
});

// 异步测试
describe('fetchUserData', () => {
  it('成功时返回用户数据', async () => {
    const mockData = { id: 1, name: 'John' };
    global.fetch = jest.fn().mockResolvedValue({
      ok: true,
      json: () => Promise.resolve(mockData)
    });

    const result = await fetchUserData(1);
    expect(result).toEqual(mockData);
  });

  it('失败时抛出错误', async () => {
    global.fetch = jest.fn().mockResolvedValue({
      ok: false,
      status: 404
    });

    await expect(fetchUserData(999)).rejects.toThrow('用户不存在');
  });
});
```

### 集成测试
```typescript
describe('用户注册流程', () => {
  let app: Express;
  let db: Database;

  beforeAll(async () => {
    app = await createTestApp();
    db = await createTestDatabase();
  });

  afterAll(async () => {
    await db.close();
  });

  beforeEach(async () => {
    await db.clear(); // 清理测试数据
  });

  it('应该创建新用户并发送欢迎邮件', async () => {
    const response = await request(app)
      .post('/api/users')
      .send({
        email: 'test@example.com',
        password: 'SecurePass123!'
      });

    expect(response.status).toBe(201);
    expect(response.body).toHaveProperty('id');

    // 验证数据库
    const user = await db.users.findByEmail('test@example.com');
    expect(user).toBeTruthy();

    // 验证邮件发送
    expect(emailService.sendWelcomeEmail).toHaveBeenCalledWith(
      'test@example.com'
    );
  });
});
```

## 部署与监控

### 部署清单
```yaml
预部署检查:
  - [ ] 所有测试通过
  - [ ] 代码审查完成
  - [ ] 依赖项无安全漏洞
  - [ ] 数据库迁移准备就绪
  - [ ] 环境变量配置正确

部署流程:
  1. 创建部署分支 (release/v1.2.3)
  2. 运行完整测试套件
  3. 构建生产版本
  4. 运行数据库迁移
  5. 部署到预发布环境
  6. 运行冒烟测试
  7. 部署到生产环境 (蓝绿/金丝雀)
  8. 验证生产功能

回滚计划:
  - 触发条件: 错误率 > 5% 或关键功能失效
  - 回滚步骤: 切换回上一个版本
  - 数据恢复: 如有必要，恢复数据库备份
```

### 监控指标
```typescript
interface SystemMetrics {
  // 性能指标
  responseTime: {
    p50: number;  // 毫秒
    p95: number;
    p99: number;
  };
  throughput: number;  // 请求/秒
  errorRate: number;  // 百分比

  // 业务指标
  activeUsers: number;
  conversionRate: number;
  revenue: number;

  // 资源指标
  cpuUsage: number;    // 百分比
  memoryUsage: number; // 百分比
  diskUsage: number;   // 百分比
}

// 报警规则
const alertRules = [
  {
    metric: 'errorRate',
    threshold: 5,  // 5%
    duration: '5m', // 持续5分钟
    severity: 'critical'
  },
  {
    metric: 'responseTime.p95',
    threshold: 1000, // 1秒
    duration: '10m',
    severity: 'warning'
  }
];
```

## 文档标准

### 代码注释
```typescript
/**
 * 计算订单折扣金额
 *
 * @param orderAmount - 订单原始金额（元）
 * @param isMember - 是否为会员
 * @param couponCode - 优惠券代码（可选）
 * @returns 折扣后的金额
 * @throws {ValidationError} 当金额为负数时
 * @example
 * ```typescript
 * const finalAmount = calculateDiscount(100, true, 'SAVE10');
 * console.log(finalAmount); // 90
 * ```
 */
function calculateDiscount(
  orderAmount: number,
  isMember: boolean,
  couponCode?: string
): number {
  if (orderAmount < 0) {
    throw new ValidationError('订单金额不能为负数');
  }

  // 实现逻辑...
}
```

### API 文档
```yaml
openapi: 3.0.0
info:
  title: 用户服务 API
  version: 1.0.0
paths:
  /api/users/{id}:
    get:
      summary: 获取用户信息
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
      responses:
        '200':
          description: 用户信息
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        '404':
          description: 用户不存在
```

## 持续学习与改进

### 技术债务管理
```markdown
## 技术债务登记

### 高优先级
1. **组件库升级**
   - 问题: FluxUI v1 已停止维护
   - 影响: 安全漏洞，缺少新功能
   - 解决方案: 升级到 FluxUI v2
   - 预估工作量: 3人周

2. **数据库索引优化**
   - 问题: 用户查询页面慢查询
   - 影响: 页面加载时间 > 3秒
   - 解决方案: 添加复合索引
   - 预估工作量: 2人天

### 中优先级
1. **测试覆盖率提升**
   - 当前: 65%
   - 目标: 80%
   - 重点: 业务核心逻辑
```

### 复盘与改进
```markdown
## 迭代复盘模板

### 本迭代亮点
1. 成功实现了...
2. 用户反馈显示...

### 遇到的问题
1. 技术问题: [描述]
   - 原因分析: [根因]
   - 改进措施: [具体行动]
2. 流程问题: [描述]
   - 原因分析: [根因]
   - 改进措施: [具体行动]

### 下迭代改进
1. 技术改进: [具体事项]
2. 流程优化: [具体事项]
3. 技能提升: [学习计划]
```

## 智能体协作协议

### 开发-测试循环
```
开发智能体 → 测试智能体 → 通过/不通过 → 修复/重试
      ↓           ↓
   代码提交     测试报告
      ↓           ↓
  质量门禁 ←─ 证据收集
```

### 交接检查点
1. **需求理解确认** - 与 PM 智能体对齐
2. **技术方案评审** - 与架构师智能体对齐
3. **代码审查完成** - 与 Reviewer 智能体验收
4. **测试通过证明** - 与测试智能体确认
5. **部署就绪检查** - 与运维智能体协调

### 质量标准
- ✅ 所有测试通过 (单元、集成、E2E)
- ✅ 代码审查无 blocker 问题
- ✅ 性能指标达标 (LCP, FID, CLS)
- ✅ 安全扫描无高危漏洞
- ✅ 文档更新完整
- ✅ 回滚方案就绪

---

*本文档持续更新，反映最新技术标准和最佳实践。*