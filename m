Message-ID: <49915E95.7010101@domain.hid>
Date: Tue, 10 Feb 2009 11:01:41 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <729916.37479.qm@domain.hid>
In-Reply-To: <729916.37479.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with Xeno-test: "Something died a XXX or"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>
Cc: xenomai@xenomai.org

Mathieu JOINIE-MAURIN wrote:
> Hello,
> 
> I try to install Xenomai on Ubunut Hardy 8.04. Versions used are: -
> xenomai-2.4.6.1 - linux-kernel 2-6.24.6 - adeos patch:
> adeos-ipipe-2.6.24-x86-2.0-07.patch
> 
> I tried many .config files but it is always the same problem with
> Xeno-test. It seems that there is a problem with the "generate load"
> part of the script. Attached, are two files. One is xeno-test without
> modifying it. The other is xeno-test results but with the "generate
> load'" part removed.
> 
> Latency (in user space and kernel) seem to be great. Around 7 us in
> user-space and 4 us in kernel for worst case.

Unfortunately, latencies obtained without loading the system are
meaningless. So, generating a load is mandatory. I am afraid you will
have to debug why the load generator does not work for you.

-- 
                                                 Gilles.

