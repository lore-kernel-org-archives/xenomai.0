Received: from mail.poptek.com.cn (unknown [120.31.135.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692FB232428
	for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.31.135.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861749; cv=none; b=Ak3g2bYBbDQCOOZ8le8MXq8+KKLo5i9aDQ+dx6kmFpKNAuXSzTyIyOMskkY93eKND1jZTYXD3umtIIVn3vY7T7lyAsdveFz5uDLWDq2fnJHTedQ8S4bxFEE4dI6I8W2ZFujW5+76efwaBcHszo/gWwpJ8vX/6zb02mI5zlUfOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861749; c=relaxed/simple;
	bh=jkw9rroMnkEIdWaA06y7YDIj75q5flzIqHrAW3Tv+SQ=;
	h=MIME-Version:Content-Type:Date:From:To:Subject:Message-ID; b=MtV3JmdGB+YTWC7exg20m/wj55zqcTsKl5bTu/JcfYlrHjVVLQsC3VuH2oHf59Su3unCAoUIJx1cBTZgEvP8TCF+XELtd8Rc/ZSNDEVQCGQs+DOikTx4Dbs8gkspaKw1OlPvMI4Gn+h25a8+ubMr2VFGZMURrSjT9nW6/cEYTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eichitek.com; spf=fail smtp.mailfrom=eichitek.com; arc=none smtp.client-ip=120.31.135.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eichitek.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=eichitek.com
Received: by mail.poptek.com.cn (Postfix, from userid 2000)
	id A556E2600ADF; Tue, 14 Jan 2025 21:26:04 +0800 (CST)
X-Spam-Level: *
Received: from mail.poptek.cn (localhost.localdomain [127.0.0.1])
	by mail.poptek.com.cn (Postfix) with ESMTPA id 52F1F26001F5
	for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 21:25:29 +0800 (CST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Jan 2025 21:25:29 +0800
From: luis@eichitek.com
To: xenomai@lists.linux.dev
Subject: Where can I find the documents of building and runing Xenomai3
 =?UTF-8?Q?app=3F?=
Message-ID: <1548af45202ceea5b29e3bfd6f762db0@eichitek.com>
X-Sender: luis@eichitek.com
User-Agent: PopTek.cn Webmail/1.0.5
X-Remote-Browser: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36
 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 Edg/131.0.0.0
X-RoundCube-Server: 192.168.98.33

Hi all,
     As title, in the source code of Xenomai 3.x (for example v3.2.6), 
there is a manual called "Installing Xenomai 3.x", which has Section 8 
"Building and Running Xenomai 3 Applications". There are two links in 
Section 8, called <building-applications-with-xenomai-3.x/> and 
<running-applications-with-xenomai-3.x/>. Where can I find these two 
documents?

Best regards and thanks,

Luis
