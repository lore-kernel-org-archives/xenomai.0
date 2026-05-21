Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3134388A
	for <xenomai@lists.linux.dev>; Thu, 21 May 2026 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396232; cv=none; b=AiRF0XRxB+IdmT+CD3+nzZxi7bxbhoDE9HJji74Ru+eH5e2KVNMRWlaEGFvJQ/nYNba1aF8LBcco+3zCeYe9uJMG1ZbY3exM81RKywPV6JRfDl+2qC/UfdG7KUTpXy9jl1MQlHcIw2TJ0D7DcfUJ2o1/rjdJgdbVN6GIiQ1xAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396232; c=relaxed/simple;
	bh=W6PQ70DkGm6CH3fwlaEF3zPER9zh07rPzJ4oktxAsa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyuBslWd5a/9amqrvEa9tXcZFHRd5CMNV/konyDRIW2f2Wpc9JHj5wcBSzFg5PFF9RWDR4IejRU0K3TjOJETNlINhlc6DG3p81iOh/l3ve9XEP1wuclz4CrnAA4oim/D0GpQ2v87vbsCMtJG937x48Jcv9+GY/BZanXhkqb2d2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHIon2Me; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHIon2Me"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44a14580111so5017656f8f.0
        for <xenomai@lists.linux.dev>; Thu, 21 May 2026 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779396229; x=1780001029; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jdMgMPIG0l/94nfFyk936x9aHdHzK+cTcI1YPqP3Yk=;
        b=nHIon2MeKC6hNMFZpntWJxN1MWWo1yJVAUdBeQeKealUAZ9wcLVHIYYt7pNgazmjBk
         ULc/PGOGWzkTWAe4QnFtLLhPLbobyA6BBZ1eTyu/iYx+5oQTTjLmzGq2Xy0uE6j/44ug
         d+g7fjVhMf2Tal1R1lNOgApUiUovpe7DcVdV17a2khCn4B93slfjPIBYN7GXDdXmqN7w
         DWZ2bG3zVwqSk6OP5UjdwqlZaf7I+XSzxh82l4K5X30Tgb2pMy6WGXNIHxmoCTDWOZs+
         eI+Uy5MI8UcSJc/VfO2K7FSjNmD6SaRjLeu55g0qaOqCFyycOJGP/GvybOTmsf3WXt7h
         yt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779396229; x=1780001029;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jdMgMPIG0l/94nfFyk936x9aHdHzK+cTcI1YPqP3Yk=;
        b=NMBSIcmX1M6C9rmNwDEzpPSGks4rCHIhtWLAY3swFjloTepGu+pf83FQIm5pjiq4PE
         sk5aUqf9VrEDDT+UhLpzwgKQiSojkIBrSz2Z+NVrTW0jAYrePWKgOsRhasGI211VsVzq
         TI/D4ZFsS57a3Czawx6a4dESHP51XJtQ+ALq3BmT7YdrBqyHRRKff8Ny/y9Sb0MHUl02
         Y3OFVUBeiqY3wQhz7iIVvwBz8jMVAJGc+z+UfK5yYhiSo8a3xwjRPZ55/Qki3VgPNYkM
         KH+zyB0UXLA7cHtx+CiFUMeOLxRvjwgdUWWqdUEDxvl6sQ1KJMcjo9w01nZnHR7jjO0g
         +puw==
X-Gm-Message-State: AOJu0Yw4Sv2Xi9HIJChd96JotXZRCiQ78Nmy+IwNn9AQrvMESihJKYyG
	zXbniETyD/jC/S8vKqolqEbnZESSWKkwhbp4+SmpDlrlC0I37Lal2PDc
X-Gm-Gg: Acq92OGAajbhTFvJhbA2RrVncAEYWBPJqIZnFh0HMW2jO/6sZOlCFcnMvd+rLk1PTMQ
	fnnLQSqCil1OyrxFrjOJjVPFt0OTcuImgKCzNVlY9i/CqISa6ftrNK7wfXzzjiqnHSIEBr/FOcv
	criegXxYuxWH0tlp/SDegULGjg2cOdy/JqDUfSC2qfAgTLrnnGinbJ+KGijL3RuYk3JQIkEjp9T
	sKPpICzkqkJZjB5GEYacAMxwOoNiSYf2Tm3ODe9ZpvdhxuUyf1fT2HCbfpIrieifcvoUE74YhAj
	028wDxu1SjkxGuF2Fmk/75djWCkLMxA7vb071NDpoP6PGCSz3Lc+A71c5yV6Dl8B3UKfc7s00YM
	UL8rhkwMf4g1s/kPepLFshCBpHa7NxVPT+ArAxwwiig+8V7Vln6iCAe63UHGOfsKXJIR3Xtq7Tb
	lj36Z0bPJJZLm32jb5XrOlQ5OfEHEjcTc=
X-Received: by 2002:a05:6000:610:b0:452:c246:ab69 with SMTP id ffacd0b85a97d-45eb36909ecmr577196f8f.13.1779396228885;
        Thu, 21 May 2026 13:43:48 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa944995sm5629524f8f.34.2026.05.21.13.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 13:43:48 -0700 (PDT)
Message-ID: <327a363e-6b79-45b2-a5b0-6b9f8a82d756@gmail.com>
Date: Thu, 21 May 2026 22:43:47 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EVL] Client UDP not receiving data
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <6f9e6ff2-95a7-402c-90d6-19f0f89bbc80@gmail.com>
 <87v7chf5xm.fsf@xenomai.org>
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Content-Language: de-CH, en-US
In-Reply-To: <87v7chf5xm.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 21.05.26 um 11:49 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> Hello
>>
>> I have issue porting an application that runs as an UDP client to OOB networking.
>>
>> The standard client pattern:
>> -connect
>> -oob_sendmsg
>> -oob_recvmsg
>> does not work.
>>
>> In Wireshark, i see the packages going out and returning with the correct ip/port
>> but oob_recvmsg() doesn't return.
>>
>> To debug, I modified the oob-net-udp example, attached. Additionally, I ported it back
>> to posix networking where it works as expected.
>>
>> Send only mode / receive with bind works well.
>>
>> Config:
>> Debian Trixie
>> linux-evl v6.12.y-cip-evl-rebase 569beef0
>> libevl r57 877d5ca
>>
> 
> I believe oob-net-udp does work as is, but not the way you seem to
> expect it, which led your to change the original logic so that two
> instances of this program always run head to tail, each one running a
> sender+receiver loop.
> 
> The original intent was to implement half-duplex roles instead, starting
> each instance either with the -S (send mode) or -R (receive mode,
> default) option switch, in order to explicitly select a role.
> 
> This allows for more configurations, like mixing the network stacks to
> use for testing. For instance, we are currently able to broadcast
> packets to listeners on port #42042 over the wire from a vanilla linux
> system (no evl) to an evl-enabled one, using VLAN-based selection of
> packets:
> 
> /*
>   * From the vanilla system, through VLAN device eno2.1
>   */
> 
> $ echo -n "Hello world" | sudo socat - udp-datagram:255.255.255.255:42042,broadcast,so-bindtodevice=eno2.1
> 
> /*
>   * From the evl system, listening to all oob interfaces using VLAN-based
>   * packet selection.
>   */
> 
> ~# oob-net-udp -R -a broadcast
> == receiver mode (<= broadcast:42042)
> == bound to port 42042
> = 11 bytes received: Hello world
> 
> With a different setup, we could connect two evl-enabled systems, like:
> 
> /*
>   * From the first evl-enabled system, sending through eth1
>   * to 10.10.10.11:42042
>   */
> 
> ~# oob-net-udp -S -a 10.10.10.11
> == sender mode (=> 10.10.10.11:42042)
> 
> /*
>   * From the second evl-enabled system, receiving from eth0,
>   * bound to 10.10.10.11 on port #42042
>   */
> 
> ~# oob-net-udp -R -a 10.10.10.11
> == receiver mode (<= 10.10.10.11:42042)
> == bound to port 42042
> 
> This said, if you believe that a dual role setup like the one you
> suggested would be nice to have to users as well, we could add it to
> oob-net-udp alongside the existing half-duplex modes. For instance,
> omitting the -R and -S keys on the command line currently defaults to
> -R. Instead, we could select the new "dual role" mode.
> 
> PS: please send (diff context, -u or git-diff) formatted patches instead
> of entire modified files, so that we can immediately grasp the essence
> of the proposed changes. Also, please make sure to separate unrelated
> changes sets in distinct patches (e.g. those changing a particular
> aspect of the logic from others which may be coding style
> fixups). Generally speaking, we follow the linux kernel coding style and
> process when it comes to submitting patches [1].
> 
> [1] https://docs.kernel.org/process/submitting-patches.html
> 

Thanks for the detailed answer. I might have been not precise enough.

The -S and the -R mode work as designed. To show the issue with connect() in evl, I changed
the -S mode to:
connect()
while{
   oob_sendmsg()
   oob_recvmsg()
}

This is the classical UDP client pattern. It works with vanilla linux (net-udp.c)
but not with evl (oob-net-udp.c), I do not receive any data.

By just sending the modified code, it is easy to explain and hopefully for you to
reproduce. This is also why I attached the files instead of sending a patch.
Be aware that this is just to demonstrate what is not working, not intended as a patch.

I run Xenomai4 in a VM and communicate with the host for debugging
but I have also a real PC as the final target where I have the same issues.

First start on the host:
echo Hello | nc -u -l 5201

Then in the VM:
sudo evl net -ei enp7s0
sudo oob-net-udp -d -i enp7s0 -a 192.168.122.1 -p 5201 -S

On the host:
Mellow sword!

In the VM:
== bound to enp7s0
== sender mode (=> 192.168.122.1:5201)
--------tx--------
IP-Adresse: 192.168.122.1
Port:       5201
Family:     512
--------rx--------
IP-Adresse: 192.168.122.155
Port:       58422
Family:     512

The package is visible in wireshark but oob_recvmsg does not return:
No "= 6 bytes received: Hello" and no second transmit.

It looks like the auto assigned and bound port from connect() is not forwarded
to the oob stage, so no data is received in oob_recvmsg().

In wireshark in the VM, I see the outgoing package 41626->5201 and the
incoming 5201->41626 where 41626 is an auto assigned port by connect.

With the code ported to vanilla linux:
connect()
while{
   sendmsg()
   recvmsg()
}
it works as expected:

Host:
echo Hello | nc -u -l 5201

VM:
sudo evl net -di enp7s0
net-udp -d -i enp7s0 -a 192.168.122.1 -p 5201 -S

Host:
Mellow sword!
Mellow sword!

VM:
== bound to enp7s0
== client mode (=> 192.168.122.1:5201)
--------tx--------
IP-Adresse: 192.168.122.1
Port:       5201
Family:     512
--------rx--------
IP-Adresse: 192.168.122.155
Port:       43042
Family:     512
= 6 bytes received: Hello

But might be evl was never intended to work using connect() in classical UDP client style?

Meanwhile, I found a workaround. Instead of connect() I just use bind(). The only disadvantage
is, that I have to manually assign a port:

bind()
while{
   oob_sendmsg()
   oob_recvmsg()
}

Normally, bind() is only used for servers and point-to-point connections but you can (miss-) use it
also for clients. A server would be:
bind()
while{
   oob_recvmsg() -> Receives a message from any client
   oob_sendmsg() -> Sends the answer back to the ip/port from the address from recvmsg
}

If you think this this example is useful, I can finalize it (for now with the bind() workaround) and also add a server mode.
So there would be 4 modes in total. With a server mode, you can run the server on one host, the client on the other and continuously
send data forward / backward and measure delays. I would use:
-T send (previously it was -S but then I have nothing for server)
-R receive
-S server: Waits for data and sends a response for each received package.
-C client: Sends data and measures how long it takes for the server to response.

As an alternative, I could just create a second example oob-net-udp-server-client.c. This would result in a bit of duplicated code but not to much.

What do you prefer?

I also created oob-net-ping in the same style as oob-net-icmp but this sends out a ping, receives the response
and measures the delay, similar as the ping command:
./oob-net-ping -i enp7s0 -a 192.168.122.1
[0] count=98, proto=0x800, ifindex=3, type=0, halen=6, mac=52:54:00:6b:05:f1 rtt=317.1us
[1] count=98, proto=0x800, ifindex=3, type=0, halen=6, mac=52:54:00:6b:05:f1 rtt=218.5us
[2] count=98, proto=0x800, ifindex=3, type=0, halen=6, mac=52:54:00:6b:05:f1 rtt=252.5us
[3] count=98, proto=0x800, ifindex=3, type=0, halen=6, mac=52:54:00:6b:05:f1 rtt=320.1us
It has to be cleaned it up a bit and integrated it into the libevl repo but then I will also send a patch.

Regards
Hannes
