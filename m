Message-ID: <500E4603.2000002@xenomai.org>
Date: Tue, 24 Jul 2012 08:51:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6B3AC2788014DD49B43AF9611365BBAA21B0B94DE9@mary.at.omicron.at>	<5009902B.7070705@xenomai.org>	<6B3AC2788014DD49B43AF9611365BBAA21B0B954F3@mary.at.omicron.at>	<500D298C.6080601@xenomai.org>
	<6B3AC2788014DD49B43AF9611365BBAA21B0B9550A@mary.at.omicron.at>
	<6B3AC2788014DD49B43AF9611365BBAA21B0B95718@mary.at.omicron.at>
In-Reply-To: <6B3AC2788014DD49B43AF9611365BBAA21B0B95718@mary.at.omicron.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai 2.6.1 on ixp4xx hangs on boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Lausch <michael.lausch@omicron.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/24/2012 08:49 AM, Michael Lausch wrote:

> Hi,
> I've some patches lying around against linux 3.0.x and xenomai 2.6 which compile and 
> the "No kuser TSC emulation" (sp?)  message when starting a xenomai application is not printed any more.
> I will merge them with the ipipe patch mentioned  in your post. (have i mentioned, i don't like outlook?). 
> 
> Can you point me to an acid test which i can use to verify if kuser TSC emulation is working correctly?


The "tsc" test in xenomai regression testsuite. Run it with "-w" and it
will try and read the tsc for as long as it takes for the hardware
counter to wrap.


-- 
                                                                Gilles.

