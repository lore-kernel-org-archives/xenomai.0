Message-ID: <50B73FB5.3080709@thrane.com>
Date: Thu, 29 Nov 2012 11:57:57 +0100
From: Jesper Christensen <jbc@thrane.com>
MIME-Version: 1.0
References: <50B73EA7.3070501@thrane.com> <50B73F44.9080900@xenomai.org>
In-Reply-To: <50B73F44.9080900@xenomai.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mutex and timers
Reply-To: jesper.christensen@cobham.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

As i suspected, thank you very much.

/Jesper B. Christensen
Development Engineer
T +45 39 55 88 02
E jesper.christensen@cobham.com
Thrane & Thrane A/S - Lundtoftegaardsvej 93D
DK-2800 Kgs. Lyngby, Denmark - www.thrane.com

On 11/29/2012 11:56 AM, Philippe Gerum wrote:
> On 11/29/2012 11:53 AM, Jesper Christensen wrote:
>> Hello
>>
>> I was wondering if (and i have a feeling i already know the answer) it
>> is a no-go to call rtdm_mutex_lock from a rtdm timer handler? I've just
>> discovered that is what we do, and i have a feeling it is causing
>> trouble (most of the time it seems to work however).
>>
> 
> no go indeed. As soon as the mutex is contented, an attempt is made to
> put the caller to sleep, which can't be done over an IRQ context. So the
> situation is essentially, a mess.
> 

