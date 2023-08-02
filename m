Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12C566E
	for <xenomai@lists.linux.dev>; Wed,  2 Aug 2023 09:15:34 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id AF72DD0A0F
	for <xenomai@lists.linux.dev>; Wed,  2 Aug 2023 09:06:03 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1CF2D40011;
	Wed,  2 Aug 2023 09:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1690967156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0AJAHuNKrbejsvrILKNQzIbzTp/3AW2jb9gmhO+pR4=;
	b=GEJoNzbbctcD6Xo6/rV5lLj0CCLpMnWubeMf5bGT5RTeEfe45ai6OVxh5ngSjbHmlaL468
	/6d39vm5mXlINt7yUrw5lLiDMrYjFijXbcbOyLJsL48UGeL1WLWAbax8Z7+grAzL34HvwD
	n4fSkX9ht6MTvDucqSdp0IVa/HCX3bD2kJJASp9sM/tI2QW6qVpGPVKNlt6VEiAYlHgRcW
	/efZcWUcOUoBYBgCj4/vsv9DkBji5IBE7gwn1KJEkznEmfmTBwzuxvS6PzXukNNy9FpJvL
	iEly0PSNrqtyrklRzwAsCyJnR7xrgl+ZKl02NViuCvEUCCBCplQtO8M+FiFg/Q==
References: <DM6PR14MB3871876E6E078D3BE974ADCBA30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB387142813E6733B5C9DEFEE7A30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <87pm46sm8y.fsf@xenomai.org>
 <DM6PR14MB38719B58539606FEA830CF9CA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB38714729ADDC7529E3268CCEA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <87fs51evhn.fsf@xenomai.org>
 <bcc0cdae5a594bcfa625e3e75fa35e17@manrolandgoss.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: dietmar.schindler@manrolandgoss.com
Cc: xenomai@lists.linux.dev
Subject: Re: data modified by second NRT write with same memory location
Date: Wed, 02 Aug 2023 11:01:17 +0200
In-reply-to: <bcc0cdae5a594bcfa625e3e75fa35e17@manrolandgoss.com>
Message-ID: <877cqderv0.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


<dietmar.schindler@manrolandgoss.com> writes:

>> From: Philippe Gerum <rpm@xenomai.org>
>> Sent: Wednesday, August 2, 2023 9:31 AM
>> ...
>> yo sang <stlfatboy@hotmail.com> writes:
>>
>> > class RTMem
>> > {
>> > public:
>> > RTMem() {}
>> >
>> > RTMem(const char* data, int size, RTMemType type) {
>> > Data = Buf;
>> > memcpy(Data, data, size);
>> > Size = size;
>> > Type = type;
>> > }
>> >
>> > intSize{};
>> > RTMemTypeType{};
>> > char*Data{};
>> > charBuf[256]{};
>> >
>> > };
>>
>> <snip>
>>
>> > static void *realtime_thread(void *arg)
>> > {
>> >    struct timespec ts;
>> >    int ret;
>> >    RTMem buf;
>> >    for (;;) {
>> >        ret = recvfrom(s, &buf, sizeof(buf), 0, NULL, 0);
>> >        if (ret <= 0)
>> >fail("recvfrom");
>> >        printf("   => %s \n", buf.Data);
>>
>> <snip>
>>
>> >
>> >     RTMem data("data1", 6, RTMEM_1);
>> >     ret = write(fd, &data, sizeof(data));
>> >     if (ret != sizeof(data))
>> >         fail("write");
>> >     memcpy(data.Data, "datadata", 9);
>> >     data.Size = 9;
>> >     data.Type = RTMEM_2;
>> >     ret = write(fd, &data, sizeof(data));
>> >     if (ret != sizeof(data))
>> >         fail("write");
>>
>> This example code is broken, badly. Please consider what the reader
>> thread actually reads, which is definitely not a value, but a descriptor
>> containing a pointer to some value, which the writer thread will
>> overwrite before realtime_thread() runs. Which explains the outcome.
>>
>> At the very least, you should have a distinct RTMem instance to feed
>> each write() with. This said, since XDDP is by design an inter-stage,
>> inter-process IPC, passing process-private pointers in messages looks
>> wrong in the first place.
>
> I think it would also work if only the reader used buf.Buf rather than buf.Data, i. e.
>
>         printf("   => %s \n", buf.Buf);
>
> since buf.Buf is copied and remains meaningful, unlike the pointer.

Agreed. I'm giving the original implementation the benefit of the doubt
assuming that such pointer would in fact mimic some kind of read cursor
on the receiver end in the actual application, unfortunately initialized
by the send site in the example.

-- 
Philippe.
