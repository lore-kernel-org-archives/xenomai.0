Message-ID: <47740C30.6080006@domain.hid>
Date: Thu, 27 Dec 2007 21:33:52 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB2E4@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB2E4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] I see negative faults
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Fillod Stephane wrote:
> Dear Xeonmai/I-Pipe maintainers,
> 
> Attached is an obvious patch (to me). Part of it is across I-Pipe.
> Is there a reason why the counter was declared signed?
> 

Well, because the number of faults was not expected to increase
indefinitely... Is it the PF count we are talking about, on a mpc85xx?

> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

