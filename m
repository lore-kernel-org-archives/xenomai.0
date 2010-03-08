Message-ID: <4B953664.3060005@domain.hid>
Date: Mon, 08 Mar 2010 18:39:48 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4B9530B5.60809@domain.hid> <4B9532EA.4070300@domain.hid>
In-Reply-To: <4B9532EA.4070300@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] First loop iteration increased latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Either you have a bug in your protocol, or something else happens, such
> as a cache effect. What is the size of the frame, what is the platform
> you are using? Could you send us the test program, which would allow us
> to reproduce the issue?

There isn't a real protocol involved, it is just reading from a shared
memory region. The platform is x86, the shared memory region is just
1024 bytes and I'm using just a few of those. I'll produce a self
contained test program and I'll send it to the list.

Cheers,
-- 
Daniele


