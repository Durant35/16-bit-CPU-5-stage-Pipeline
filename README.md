# 16-bit CPU by 5-stage Pipeline

## 描述
　　本科二年级《数字系统设计》上完成的一个课程项目，使用的开发环境是 **Xilinx ISE 12.3** 。通过编写**Verilog HDL** 实现了一个5级流水线的16位CPU，并通过ISE软件进行软件仿真与调试。  
　　五级流水线将整体的处理过程分为取指令 **(IF)**、指令译码 **(ID)**、执行 **(EX)**、存储器访问 ** (MEM)**和寄存器回写 **(WB)**。  
　　本仓库仅用作代码保存与共享目的，想要了解本项目更多细节可以通过上述<a href="/12353022_CPU-Report.pdf">实验报告</a>获取。

## 目录介绍
.  
├── 12353022_CPU-Report.pdf 本次试验的实验报告  
├── Simulation Code 仿真文件文件夹  
|   ├── cpu_top.v 用于仿真的顶层模块代码  
|   ├── mips.v 核心 mips 模块源代码  
|   ├── alu.v ALU 子模块源代码  
|   ├── instruction_memory.v 指令内存模块代码  
|   ├── data_memory.v 数据内存模块代码  
|   └── cpu_tb.v 仿真文件代码  
├── Source Code 设计文件文件夹  
|   ├── mips.v 核心 mips 模块源代码  
|   └── alu.v ALU 子模块源代码  
└── MIPS ISE 设计文件夹