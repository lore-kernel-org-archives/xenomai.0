Message-ID: <50AE570E.10003@ruggedcom.com>
Date: Thu, 22 Nov 2012 11:47:10 -0500
From: Makarand Pradhan <makarandpradhan@ruggedcom.com>
MIME-Version: 1.0
References: <50AE49ED.9020804@ruggedcom.com> <50AE4F97.8030102@xenomai.org>
In-Reply-To: <50AE4F97.8030102@xenomai.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mutex enhancement for Auto relaxed threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,

lock mutex1
lock mutex2
unlock mutex1
unlock mutex2

As per my current implementation, I expect the thread to relax after 
unlocking mutex1. If another RT thread starts waiting on mutex2, I 
expect the thread holding the mutex will harden and start running in 
primary again. Will quickly test this and get back.

I did consider this scenario but since we never use such a behaviour in 
our system, did not pursue it further.

This brings up another question that I was contemplating. Do we want to 
harden unless there is another RT thread wanting this mutex? If not then 
the implementation becomes simpler and the scenario mentioned would also 
get addressed automatically.

Rgds,
Mak.


> I did not look in details at your code, but what if I do
>
> lock mutex1
> lock mutex2
> unlock mutex1
> unlock mutex2
>
> ?
>


-- 
___________________________________________________________________________
NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged information.  If you are
not the intended recipient, please notify the sender immediately by return e-mail and delete this
e-mail and any copies.  Any dissemination or use of this information by a person other than the
intended recipient is unauthorized and may be illegal.
_____________________________________________________________________

  


