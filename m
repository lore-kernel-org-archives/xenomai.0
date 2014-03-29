Message-ID: <5336CC15.8070102@xenomai.org>
Date: Sat, 29 Mar 2014 14:35:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADoY7i8=SSBVO6R7eiGtMLb9ZnAsXj+mC4L_pDRs3-zDBaP7aQ@mail.gmail.com>
In-Reply-To: <CADoY7i8=SSBVO6R7eiGtMLb9ZnAsXj+mC4L_pDRs3-zDBaP7aQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] IRQ Handler latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Le 29/03/2014 00:41, Newell Jensen a écrit :
> Hello,
> 
> I have successfully created an RTDM driver that uses the EPIT timer on the
> i.mx6dl-sabresd board.  The reason I created this driver is I wanted to see
> what the hard interrupt latency is using Xenomai.
> 
> AFAIK, I am using the RTDM skin in the proper way.  However, I wanted to
> run my code by the experts (you guys), to see if there is any improvements
> that I can make.
> 
> Here is a link to my code:  http://pastebin.com/TFWLq9mq

Also, the code measuring latency seems all wrong. Debugging this looks
like a waste of time:
- we provide the latency test, which we hope is reasonably debugged, so
duplicating the effort is a waste of (our) time;
- from the code, I would guess the EPIT runs at 6 MHz, whereas the
cortex A9 has timers running at 400 or 500 MHz, which results in lower
latencies for accessing their registers.

-- 
Gilles.

