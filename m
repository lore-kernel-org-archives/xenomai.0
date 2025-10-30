Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582172773F0
	for <xenomai@lists.linux.dev>; Thu, 30 Oct 2025 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839621; cv=none; b=SCMTagNstKqpIp9NERyP0QynX7BjemJD/iyhInwplpjTiU/ZPpsys6Hm9SXa73xjn6mdetrE59YF/Tm1KgLGMlwd8L9yy7JO4NltQ3tqoU01nJ1P5Bt1Fklndm4eqzwaVc+a9hn2GiK8+A44FoMwzZA5q5xkhRBqA1pfWEW+5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839621; c=relaxed/simple;
	bh=0ALqYF/VBIqUXZRgTx+7OTl3tiVUj8qZPUh8C6Q26V8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tirk9kYrmgH9Dn8SSBnSFbRuw/xFoPsHRGFnAKnLaf6g8dUK7oSTdQtVTB4+oancHMiPc3EIZ2Qe8syPdL+arYaHsCjQElCE8JcqB9/Hx3mnhEf8/f3M5d2iIy8yNdsPy+vyuiOnvBdstxU3SB40kYVfiHvMuh2l13aYhO8ayAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mntHB8pC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mntHB8pC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475d9de970eso8789015e9.1
        for <xenomai@lists.linux.dev>; Thu, 30 Oct 2025 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761839617; x=1762444417; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C06wnAI3amj6W2D80vMnpI87Jopxw9gDTd00YUsLig4=;
        b=mntHB8pCC360jixINYjECIMpJFtpmThOtefU55R+KGu9OAXDJqVy6SHQ2kdnEZz8vR
         R/9EILTd4euX9XABJtGhnNplD8FKWi2sqvns7qLmAqfNinNjnoBR8efnQ1eQXEQgsxVB
         iltcQ+4Z29DB9tBIBLQD6TaHRCvbFG0smG9+VIopeEvySLdMKO6IWc8jdZI+ybRNVUsi
         IqwxIO/k4d+qDG3DrqbKzyYJdamMtvFYDhQfE03G8G+TleOJszImEh6frp6N+ieb1y6f
         Ub9A9kSbvfsxhDG+3zAY87oJZyW4XubT/rn7T51IzuVcwHPXqR+1tjRDal913/j3CYF2
         SpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839617; x=1762444417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C06wnAI3amj6W2D80vMnpI87Jopxw9gDTd00YUsLig4=;
        b=WQ9IjS3Xun9Ba4j+ifiosgP8ur82wHhEpvOxhe1PuokU/DdBxMooYcvbujeFEaCEfr
         0pJtaMY4nIk43i0QBRB4penwCVcRhFZfI1yiqg2C44VG7C6f+SQUTUbCPwXvh2BlOvYF
         dL8xYuPodtgpFbRUmccDLDsy7VWZT+UA3ppXJexo5sJGxRAjYgx9pR85Q2cFQhxPWSQ9
         Tup4pefI4pCforZYdkxYM1x/oGSJ936+KUsA+QcvjtI/p+OTeZZ2qNvFE8vWsjIcrBlo
         gNG9SOLNSfTzveu+u+Md7EkGiEb1K3eKnPw6L4J9LG0xKCpNFpi2dgGOrk+9hyw2Wiaa
         vA/w==
X-Gm-Message-State: AOJu0YzatBgoQmePUCEQYFl5FePPMzuyTGnAhIaQ4Me61UENtLI+xyHs
	hqBtl/yowzeSq26wKQ/3xxWBZu9AbDipUZFCMNUgHvkKoFMOAmfn/8uSDt8S2WObRk8=
X-Gm-Gg: ASbGncuSKHnPxdNqrfY/SDPbFSiy4H7LvNR1a+yi6tX8ycKpDAoMxcsg9YKscULE0vo
	p270CIgs1K2/a144+PsQAjV5MZzWyKIaWS13BqevJ8iMBN0Etae3Az2RMtllIpETZz+2HSC2Rdb
	9D9fIEixJlyTdppQjRTBllyz3pmAMHh342WPfapBwikyK7yJCrKUEeXocFwakJrkMuQE96CLhT4
	sienZN+XiJxgsNBjRTBwVB9z/gx3PghxXKmO6QvjsqNmHGrZsLs3QcGbCozG21oRm6F+sRRVmCa
	y8sON6OxnWj0QOmkNKjCMrqFY8CdZewlsA2ZWefDGEBpRtrCGmq4CHxWmYkCm3+3ODzrWlrWJfH
	zjZLqoXCUSb8jHd9lYczO/wFZEx8kDOiFt4TkkuNkTxATI8ARX+tD5Wknou14/0G6m/IcYhifxT
	SAjpEL3sbU2D1xFCS8SdVvsWedTOMnXXJzfCD+TjPxFsECZfKD2L2LjeYbCzWYori8egU=
X-Google-Smtp-Source: AGHT+IEHDMk+w7/LYeXV5+i4DG6yKKr1ANYbNUDbnX0vvx97hLttgD19q7/DaxX1gahn8KbOGT8YRA==
X-Received: by 2002:a05:600c:6389:b0:475:de05:6611 with SMTP id 5b1f17b1804b1-47730793c68mr2266735e9.7.1761839616942;
        Thu, 30 Oct 2025 08:53:36 -0700 (PDT)
Received: from pop-os.sigmatek.local (83-215-235-230.stat.cablelink.at. [83.215.235.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbb20sm32608509f8f.18.2025.10.30.08.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:53:36 -0700 (PDT)
From: m.kurz92@gmail.com
To: xenomai@lists.linux.dev
Cc: Markus Kurz <m.kurz92@gmail.com>
Subject: [PATCH 2/2] docs(xeno3): fix warnings in doxygen build
Date: Thu, 30 Oct 2025 16:53:29 +0100
Message-Id: <20251030155329.1337840-3-m.kurz92@gmail.com>
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

Remove obsolete doxygen configuration and change to the correct default
paper_type of a4.

Signed-off-by: Markus Kurz <m.kurz92@gmail.com>
---
 doc/doxygen/xeno3prm-common.conf.in | 22 ----------------------
 doc/doxygen/xeno3prm-html.conf.in   | 10 ++++++----
 doc/doxygen/xeno3prm-latex.conf.in  | 10 ++++++----
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/xeno3prm-common.conf.in
index 1becf3dc5..71db05686 100644
--- a/doc/doxygen/xeno3prm-common.conf.in
+++ b/doc/doxygen/xeno3prm-common.conf.in
@@ -459,12 +459,6 @@ VERBATIM_HEADERS       = YES
 
 ALPHABETICAL_INDEX     = NO
 
-# If the alphabetical index is enabled (see ALPHABETICAL_INDEX) then 
-# the COLS_IN_ALPHA_INDEX tag can be used to specify the number of columns 
-# in which this list will be split (can be a number in the range [1..20])
-
-COLS_IN_ALPHA_INDEX    = 5
-
 # In case all classes in a project start with a common prefix, all 
 # classes will be put under the same header in the alphabetical index. 
 # The IGNORE_PREFIX tag can be used to specify one or more prefixes that 
@@ -714,14 +708,6 @@ EXTERNAL_GROUPS        = YES
 # Configuration options related to the dot tool   
 #---------------------------------------------------------------------------
 
-# If the CLASS_DIAGRAMS tag is set to YES (the default) Doxygen will 
-# generate a inheritance diagram (in HTML, RTF and LaTeX) for classes with base or 
-# super classes. Setting the tag to NO turns the diagrams off. Note that this 
-# option is superseded by the HAVE_DOT option below. This is only a fallback. It is
-# recommended to install and use dot, since it yields more powerful graphs.
-
-CLASS_DIAGRAMS         = YES
-
 # If set to YES, the inheritance and collaboration graphs will hide 
 # inheritance and usage relations if the target is undocumented 
 # or is not a class.
@@ -816,14 +802,6 @@ DOTFILE_DIRS           =
 
 MAX_DOT_GRAPH_DEPTH    = 0
 
-# Set the DOT_TRANSPARENT tag to YES to generate images with a transparent 
-# background. This is disabled by default, which results in a white background. 
-# Warning: Depending on the platform used, enabling this option may lead to 
-# badly anti-aliased labels on the edges of a graph (i.e. they become hard to 
-# read).
-
-DOT_TRANSPARENT        = NO
-
 # Set the DOT_MULTI_TARGETS tag to YES allow dot to generate multiple output 
 # files in one run (i.e. multiple -o and -T options on the command line). This 
 # makes dot run faster, but since only newer versions of dot (>1.8.10) 
diff --git a/doc/doxygen/xeno3prm-html.conf.in b/doc/doxygen/xeno3prm-html.conf.in
index e62df4d70..b8119b0b3 100644
--- a/doc/doxygen/xeno3prm-html.conf.in
+++ b/doc/doxygen/xeno3prm-html.conf.in
@@ -153,11 +153,13 @@ MAKEINDEX_CMD_NAME     = makeindex
 
 COMPACT_LATEX          = NO
 
-# The PAPER_TYPE tag can be used to set the paper type that is used
-# by the printer. Possible values are: a4, a4wide, letter, legal and
-# executive. If left blank a4wide will be used.
+# The PAPER_TYPE tag can be used to set the paper type that is used by the
+# printer. Possible values are: a4 (210 x 297 mm), letter (8.5 x 11 inches),
+# legal (8.5 x 14 inches) and executive (7.25 x 10.5 inches).
+# The default value is: a4.
+# This tag requires that the tag GENERATE_LATEX is set to YES.
 
-PAPER_TYPE             = a4wide
+PAPER_TYPE             = a4
 
 # The EXTRA_PACKAGES tag can be to specify one or more names of LaTeX
 # packages that should be included in the LaTeX output.
diff --git a/doc/doxygen/xeno3prm-latex.conf.in b/doc/doxygen/xeno3prm-latex.conf.in
index a7611080c..059cc8414 100644
--- a/doc/doxygen/xeno3prm-latex.conf.in
+++ b/doc/doxygen/xeno3prm-latex.conf.in
@@ -141,11 +141,13 @@ MAKEINDEX_CMD_NAME     = makeindex
 
 COMPACT_LATEX          = NO
 
-# The PAPER_TYPE tag can be used to set the paper type that is used
-# by the printer. Possible values are: a4, a4wide, letter, legal and
-# executive. If left blank a4wide will be used.
+# The PAPER_TYPE tag can be used to set the paper type that is used by the
+# printer. Possible values are: a4 (210 x 297 mm), letter (8.5 x 11 inches),
+# legal (8.5 x 14 inches) and executive (7.25 x 10.5 inches).
+# The default value is: a4.
+# This tag requires that the tag GENERATE_LATEX is set to YES.
 
-PAPER_TYPE             = a4wide
+PAPER_TYPE             = a4
 
 # The EXTRA_PACKAGES tag can be to specify one or more names of LaTeX
 # packages that should be included in the LaTeX output.
