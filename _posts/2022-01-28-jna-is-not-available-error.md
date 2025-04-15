---
title: "JNA Is Not Available Error"
layout: post
date: 2022-01-28 03:47:41 +0000
tags: [arm64, arm, apple silicon, macbook pro, java, jna, java native access, elasticsearch@6]
---

We continue talking about errors that I'm encountering on an ARM-based Macbook Pro. Luckily, today is a short one.

If you see an error mentioning that JNA is unable to load inside <a href='https://formulae.brew.sh/formula/elasticsearch@6' target='_blank'>elasticsearch@6</a>:

```bash
elastic | [2022-01-27T10:06:44,451][WARN][o.e.b.Natives] [unknown] unable to load JNA native support library, native methods will be disabled.
```

You need to replace the JNA package with a newer version.

Download the <a href='https://github.com/java-native-access/jna' target='_blank'>latest JNA version</a>, and place it into:

```bash
/opt/homebrew/Cellar/elasticsearch@6/6.8.23/libexec/lib
```

Don't forget to remove the old version.[^1]

You can also run the following commands (for macOS) to replace jna-5.5.0.jar with jna-5.10.0.jar (working as of 01/2022):

```bash
wget -P $(brew --prefix elasticsearch@6)/libexec/lib https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.10.0/jna-5.10.0.jar && rm jna-5.5.0.jar
```

-----
## Footnotes
[^1]: Which will most likely will be jna-5.5.0.jar
