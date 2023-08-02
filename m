Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36BA4C9D
	for <xenomai@lists.linux.dev>; Wed,  2 Aug 2023 07:47:45 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67CE7C000E;
	Wed,  2 Aug 2023 07:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1690962457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8+LDvpx6x2vxlohDjGHoGfLH+/U43SmYsSAMRMJm3s=;
	b=RF4trYyd7NOEEDd6GDry0RN+aOVrzyWvuahzYb5fJOqM81HknviN9IEWbCOsZPlIi/XEyO
	cMEpqPX5zNP8OC2eP59q/8rKI+VKiDR8/JJK1FZdwCUmbtazuK9XN2pryghnBO9Dhvuuo5
	1kkz1bVXfPkmTae9QcTl/7axTR1nfKgrGKLPZ2TVO2H3Yf7TX0I34MGkmyxmwIjzY7O2bV
	VPy6uJX0iKvZkxet9WJFE9V8DWygBBkxSwS2LIkL7ALWTw8lhTbpVVrVk9/KH7cQOfhPje
	Pl8NAPbnrz45lIw71oHdfDVSq3BUXiGv3a3k8uJWoqeyHA35BmHB8X67NkaQQw==
References: <DM6PR14MB3871876E6E078D3BE974ADCBA30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB387142813E6733B5C9DEFEE7A30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <87pm46sm8y.fsf@xenomai.org>
 <DM6PR14MB38719B58539606FEA830CF9CA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB38714729ADDC7529E3268CCEA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: yo sang <stlfatboy@hotmail.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: data modified by second NRT write with same memory location
Date: Wed, 02 Aug 2023 09:30:50 +0200
In-reply-to: <DM6PR14MB38714729ADDC7529E3268CCEA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
Message-ID: <87fs51evhn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


yo sang <stlfatboy@hotmail.com> writes:

> class RTMem
> {
> public:
> 	RTMem() {}
>
> 	RTMem(const char* data, int size, RTMemType type) {
> 		Data = Buf;
> 		memcpy(Data, data, size);
> 		Size = size;
> 		Type = type;
> 	}
>
> 	int			Size{};
> 	RTMemType	Type{};
> 	char*		Data{};	
> 	char		Buf[256]{};
>
> };

<snip>

> static void *realtime_thread(void *arg)
> {
>    struct timespec ts;
>    int ret;
>    RTMem buf;
>    for (;;) {
>        ret = recvfrom(s, &buf, sizeof(buf), 0, NULL, 0);
>        if (ret <= 0)
>			fail("recvfrom");
>        printf("   => %s \n", buf.Data);

<snip>

>
>     RTMem data("data1", 6, RTMEM_1);
>     ret = write(fd, &data, sizeof(data));
>     if (ret != sizeof(data))
>         fail("write");
>     memcpy(data.Data, "datadata", 9);
>     data.Size = 9;
>     data.Type = RTMEM_2;
>     ret = write(fd, &data, sizeof(data));
>     if (ret != sizeof(data))
>         fail("write");

This example code is broken, badly. Please consider what the reader
thread actually reads, which is definitely not a value, but a descriptor
containing a pointer to some value, which the writer thread will
overwrite before realtime_thread() runs. Which explains the outcome.

At the very least, you should have a distinct RTMem instance to feed
each write() with. This said, since XDDP is by design an inter-stage,
inter-process IPC, passing process-private pointers in messages looks
wrong in the first place.

-- 
Philippe.
