Message-ID: <54E77997.7050808@mitre.org>
Date: Fri, 20 Feb 2015 13:14:47 -0500
From: Jeffrey Melville <jmelville@mitre.org>
MIME-Version: 1.0
References: <CALe7ZU2FV4WTd-ACRYwLyz6hC1-7NG3rCqcL3Ke5t=k74DGmeA@mail.gmail.com>
In-Reply-To: <CALe7ZU2FV4WTd-ACRYwLyz6hC1-7NG3rCqcL3Ke5t=k74DGmeA@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_event_wait not working as expected
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 2/20/2015 4:01 AM, JAY KOTHARI wrote:
> Hello,
>       I am using rtdm_event_wait() which returns 0 even I havn't used
> rtdm_event_signal(). My rtdm driver is not going into blocking state.
> I am using arm platform. On x86 platform this api worked
> perfectly.What might be I missing?
> 
> Thank you
> 
> Jay Kothari
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 
Are you calling rtdm_event_wait() from a non-RT context? I noticed in my
application* that rtdm_event_wait() always returns 0 in non-RT and I
needed to ensure rtdm_event_wait() is only called from RT context.

I'm not sure if 0 is the intended return value or not, but the
documentation does specify that NRT isn't a valid calling context.

*Zynq, Kernel 3.8, Xenomai 2.6.4.

Jeff

(Sorry, forgot to reply to list the first time)

