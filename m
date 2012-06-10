Message-ID: <2c1ae8697f908af93767f0bf43e488ba.squirrel@localhost>
In-Reply-To: <CAGTNcBsF5rjM=zYWsHVAAmZbfhL8EsmJa29R1AuV6biaZkLUnQ@mail.gmail.com>
References: <CAGTNcBt+DrdbxnewSxFi3gJjnHKrgE_rB8OJaRvMQWe8uX8ORg@mail.gmail.com>
	<CAGTNcBsrjvd_bWx1YN=aeXgiC1B3o+Y_bsW732y=B0xnaqPkVw@mail.gmail.com>
	<4FD2EB49.1030105@xenomai.org>
	<CAGTNcBsF5rjM=zYWsHVAAmZbfhL8EsmJa29R1AuV6biaZkLUnQ@mail.gmail.com>
Date: Sun, 10 Jun 2012 11:49:09 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] I-pipe 2.6.38.8-x86-2.11-02 reports illicit call from
 domain Xenomai (on x86 32-bit)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Josh Bowman <jbowman@facts-inc.com>
Cc: xenomai@xenomai.org


Josh Bowman wrote:
> With CONFIG_KGDB disabled in the kernel config, the ipipe trace is no
> longer being generated. (IPIPE_DEBUG_CONTEXT *is* still enabled.)
>
> I haven't needed kgdb yet, and haven't learned to use it; it was
> enabled in my kernel by mistake.
>
> If you think there might still be a problem here, and there's anything
> I can do to help, please let me know.

Current I-pipe patch is not supposed to work with kgdb, so, it is normal
to have to disable the option.

-- 
                                              Gilles


