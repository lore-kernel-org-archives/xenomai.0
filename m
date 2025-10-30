Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983362877D8
	for <xenomai@lists.linux.dev>; Thu, 30 Oct 2025 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839620; cv=none; b=qzKd9N4GEdA7MKdwFucMyXjBFJ76A4VlsJl+dEuRt0YTTWGpfo8L0PBeaVchtvyfyAYUWuuBGnm50RxHXIu6eAj2sKD+2s0BUWOAeJ3mL9II88PBNqySKrE+SUW/zpftcgCrWs5WBI9jsK2lGT7Wyv/HfJ7xi/rnB63nFTXT//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839620; c=relaxed/simple;
	bh=7H9ebmTJu+26dcyGFZgKou+Dy28PORbXMtk460u7004=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZOiAIECtO9vZ4ZZ49xFc/p4crjHATE6Pm9GajK8GzVlBlF+KrGh4NKwZln70MeuIYeB3Mskv6RUjJXRXSG2O3JpzLGUofxXmLhkcz8R1YcGl+GmG5JXq5R1UxKWB6Q99coLo6+TM0Xll5qqIbrNWVLVvoJhcA+by2Xhq1kV5/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xn5XS3dz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn5XS3dz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475dae5d473so9967905e9.2
        for <xenomai@lists.linux.dev>; Thu, 30 Oct 2025 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761839616; x=1762444416; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPaA8HnKfQHWtHraIZNiSqTqTzCOuwAaG5pGUQbudFM=;
        b=Xn5XS3dzJfOlFrzcKZMB0ThPiaYaz9Xaqz+Pg6VT5kmURREP3Impns7eeog+7hlz+D
         y+3ORmtinuKkSG7E+3g3RybPnwuu6iMXunowIoWAaJ8Xf+WIsPrDOPJEZ72RGz2KJGM9
         zm2s2VOMl5lsKoN86DlG+JxBGDrMvRrqBJCFYCVT252ZcVTcuSbgW3J+tO2XSQHLsp2R
         jWd/roJrVNghCtw2K0e7uMod5Q0oGG3iwyDrD57xUrnmp7kqKIEUfwprF1Gr6WZnyVwR
         XTZCwIrCZ0QMFUhZK8umP+9enXfnBOwx3sVtUA1zOc9xYCTn6oCAlPxmjlmC01NFSooC
         Tqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839616; x=1762444416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPaA8HnKfQHWtHraIZNiSqTqTzCOuwAaG5pGUQbudFM=;
        b=Y493xygtdt/+QaJyuoxxqTx67+bYGkBLu8A48V5k+22U9zQWGHgPN7iIeiLCVJ5Ch1
         OAS28ZV/RAvbMVmEBcb5aSrjkNgJODYqFJswmIzLlB8THG0Thpov5xv0U4aM2WT4C17r
         bVQcFKXewZTK05FNmgWmGCz8FRrte3JgSUBu5yRXY/j58e3jlGxmLuyFDXJCNgO4a2IU
         zmHgFbMqAAAzzpnPvGm2yQgD2FeOSl5jge8c4fv6KaSQA6RIvQEhszii2yqYdSbRIsLJ
         9M4Vam9kiWQspwLQRdjnC1j9o8rswthVP/lcZ/eRRFGbKojiAbW0tLfzpgy1UJU6zrF3
         2FZA==
X-Gm-Message-State: AOJu0Yw27Skj8e/dgSRacL1tHv6Yddd7r2i7K+pqHJZLRGMexrLno0B7
	Rim621QoHIVb2P7bcCjs49xMHfYLGNMGjv42o99j7lrQ/L65qiEkPwt1xQP1ajOyZBU=
X-Gm-Gg: ASbGncuH3wnuOCJvtIsR9ZN/3jzP/B+HTkFE380LuWHZ5ZzCTjzAOSmHN/Du9AFKh8p
	MzTnp++WtNpopI3s48PYerUmhZcktRpj/hAq1OZMnqsRaRQ/7tru51mzm1pmj+/RPiLxCnyTTsw
	hqt39riQulMrCsLF3PS1NFonHkZFRcdF/DOj9iXQZRPAn4BkLL3Obo+D5ZKDR0bjeLxIz97xe8x
	J9JCG1GtgFhVCTX1JPvpfNeT0ts6fjA4GskYuPovAhkMDvF4LvKdgRrofYEo+iNlJAy/xgewsUO
	ZU/XEryo1Jdri6XSIx3k7paBBDKpYgxsCCQvsUAS9fzNw09uqgZ2lSKrvUg/L2waVkqnI30LLp3
	JNGv5l3kkA9MLxFTjHxcaHKK1DTo4uBnN/VKM1qO+PV1hxxrK72I8DXmBJhQcO8KfnUrcrYU/fo
	YkkWYcH09bkpgy/olc26jIhJ+mjlt9tsQnhMJwBl3ur7XLTBYsPomdtpddY9U42GTcpIk=
X-Google-Smtp-Source: AGHT+IFhchC/IBOs1MV9iV0T0236RS/h6p7GuNRwqaZi/Q0tJw575DOzADzyQNQgb5nrXnrNOJSEKQ==
X-Received: by 2002:a05:600c:5026:b0:475:da13:256b with SMTP id 5b1f17b1804b1-477308c6094mr1416205e9.38.1761839616342;
        Thu, 30 Oct 2025 08:53:36 -0700 (PDT)
Received: from pop-os.sigmatek.local (83-215-235-230.stat.cablelink.at. [83.215.235.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbb20sm32608509f8f.18.2025.10.30.08.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:53:36 -0700 (PDT)
From: m.kurz92@gmail.com
To: xenomai@lists.linux.dev
Cc: Markus Kurz <m.kurz92@gmail.com>
Subject: [PATCH 1/2] docs(xeno3): adjust the size of the search bar
Date: Thu, 30 Oct 2025 16:53:28 +0100
Message-Id: <20251030155329.1337840-2-m.kurz92@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030155329.1337840-1-m.kurz92@gmail.com>
References: <20251030155329.1337840-1-m.kurz92@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markus Kurz <m.kurz92@gmail.com>

The search bar used to search through the API documentation had a
font-size of 8px, which was barely visible. Therefore, this commit
adjusts the font-size of the search bar, the drop down menu of the
search, and also the livepreview to 1.2em of the base font-size of the
documentation which is 14px.

Changes to the xeno3prm-html.conf.in had to be made in order for doxygen
to use the extra stylesheet.

Signed-off-by: Markus Kurz <m.kurz92@gmail.com>
---
 doc/doxygen/search-style.css      | 25 +++++++++++++++++++++++++
 doc/doxygen/xeno3prm-html.conf.in | 14 ++++++++------
 2 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 doc/doxygen/search-style.css

diff --git a/doc/doxygen/search-style.css b/doc/doxygen/search-style.css
new file mode 100644
index 000000000..b08c0a865
--- /dev/null
+++ b/doc/doxygen/search-style.css
@@ -0,0 +1,25 @@
+#MSearchSelect {
+    font-size: 1.2em !important;
+}
+
+#MSearchBox {
+    height: 1.4em !important;
+}
+
+#MSearchField {
+    font-size: 1.2em !important;
+    width: 14em !important;
+}
+
+#MSearchSelectWindow {
+    font-size: 1.2em !important;
+}
+
+.SelectItem {
+    font: 1.2em var(--font-family-search) !important;
+}
+
+.SRPage .SREntry {
+    font-size: 1.2em !important;
+}
+
diff --git a/doc/doxygen/xeno3prm-html.conf.in b/doc/doxygen/xeno3prm-html.conf.in
index d8f8fc397..e62df4d70 100644
--- a/doc/doxygen/xeno3prm-html.conf.in
+++ b/doc/doxygen/xeno3prm-html.conf.in
@@ -29,12 +29,14 @@ HTML_HEADER            =
 
 HTML_FOOTER            =
 
-# The HTML_STYLESHEET tag can be used to specify a user-defined cascading
-# style sheet that is used by each HTML page. It can be used to
-# fine-tune the look of the HTML output. If the tag is left blank doxygen
-# will generate a default style sheet
-
-HTML_STYLESHEET        =
+# The HTML_EXTRA_STYLESHEET tag can be used to specify additional user-defined
+# cascading style sheets that are included after the standard style sheets
+# created by Doxygen. Using this option one can overrule certain style aspects.
+# This is preferred over using HTML_STYLESHEET since it does not replace the
+# standard style sheet and is therefore more robust against future updates.
+# Doxygen will copy the style sheet files to the output directory.
+
+HTML_EXTRA_STYLESHEET = @top_srcdir@/doc/doxygen/search-style.css
 
 # If the GENERATE_HTMLHELP tag is set to YES, additional index files
 # will be generated that can be used as input for tools like the
