# FluxUI 组件库索引

> 高级开发者参考：所有 FluxUI 组件都可用，以官方文档为准。

## 核心组件

### 布局组件
- **容器** (`flux:container`) - 响应式容器，支持断点
- **栅格** (`flux:grid`) - 基于 CSS Grid 的布局系统
- **堆叠** (`flux:stack`) - 垂直或水平堆叠内容
- **分隔器** (`flux:separator`) - 视觉分隔线

### 交互组件
- **按钮** (`flux:button`) - 多种变体：主要、次要、幽灵、危险
- **链接** (`flux:link`) - 语义化链接，支持内部/外部
- **输入框** (`flux:input`) - 表单输入，带标签和错误状态
- **选择器** (`flux:select`) - 下拉选择，支持搜索
- **复选框** (`flux:checkbox`) - 单选框和复选框组
- **开关** (`flux:toggle`) - 切换开关

### 数据展示
- **卡片** (`flux:card`) - 内容容器，支持头、体、脚
- **表格** (`flux:table`) - 数据表格，支持排序、分页
- **列表** (`flux:list`) - 项目列表，支持图标、动作
- **徽章** (`flux:badge`) - 状态标记，多种颜色

### 反馈组件
- **警告** (`flux:alert`) - 通知消息，支持类型：信息、成功、警告、错误
- **对话框** (`flux:dialog`) - 模态对话框，支持表单
- **提示框** (`flux:tooltip`) - 悬停提示
- **进度条** (`flux:progress`) - 加载进度指示器

### 导航组件
- **导航栏** (`flux:navigation`) - 主导航，支持多级菜单
- **标签页** (`flux:tabs`) - 内容切换标签
- **面包屑** (`flux:breadcrumb`) - 路径导航
- **侧边栏** (`flux:sidebar`) - 侧边导航菜单

## 高级组合模式

### 表单组合
```html
<flux:form>
  <flux:input label="用户名" required />
  <flux:input type="password" label="密码" required />
  <flux:checkbox label="记住我" />
  <flux:button type="submit">登录</flux:button>
</flux:form>
```

### 数据表格
```html
<flux:table data={users}>
  <flux:column header="ID" field="id" />
  <flux:column header="姓名" field="name" sortable />
  <flux:column header="邮箱" field="email" />
  <flux:column header="操作">
    <flux:button size="sm">编辑</flux:button>
  </flux:column>
</flux:table>
```

### 卡片布局
```html
<flux:grid cols="3" gap="4">
  <flux:card>
    <flux:heading size="lg">产品</flux:heading>
    <flux:text>产品描述内容</flux:text>
    <flux:button>了解更多</flux:button>
  </flux:card>
</flux:grid>
```

## 主题集成

所有组件自动支持：
- **亮色/暗色主题** - 通过 CSS 变量切换
- **自定义调色板** - 通过 `--flux-*` CSS 变量覆盖
- **响应式设计** - 移动端优先断点系统
- **无障碍访问** - WCAG 2.1 AA 合规

## 性能提示

1. **懒加载** - 大型组件库使用动态导入
2. **Tree Shaking** - 只导入使用到的组件
3. **服务端渲染** - 支持静态生成和 SSR
4. **CSS 提取** - 生产环境提取关键 CSS

## 官方资源

- [FluxUI 官方文档](https://fluxui.dev/docs)
- [组件 API 参考](https://fluxui.dev/docs/components)
- [设计系统指南](https://fluxui.dev/docs/design-system)
- [示例项目](https://github.com/fluxui/examples)

---

*最后更新：2026-03-12 | 版本：FluxUI v2.3.1*