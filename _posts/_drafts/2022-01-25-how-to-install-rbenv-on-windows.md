---
title: "DRAFT: How to Install rbenv on Windows"
layout: post
date: 2022-01-25 02:37:36 +0000
tags:
 -
---

<p class="message">
  We cannot install <a href='https://github.com/rbenv/rbenv' target='_blank'>rbenv</a> on Windows natively. rbenv is only available on macOS and Linux, but by using Window's <a href='https://docs.microsoft.com/en-us/windows/wsl/about' target='_blank'>WSL</a>, we can install rbenv on Windows as if it's Linux.
</p>

In short, Windows Subsystem for Linux is a built-in Linux environment provided by Windows. It allows us to use Linux tools in a Windows machine without dualbooting or spinning virtual machines.

Follow the steps to install rbenv on your Window's WSL.

1. Open a Command Prompt or PowerShell, as Administrator and install WSL
{% include copy.html %}
```bash
wsl --install
```
2. After the installation completes, restart your computer. When you log in, it will prompt you to create your WSL account. Follow the instructions to complete your WSL setup.

-----
## Footnotes
[^1]: 
