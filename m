Message-ID: <50CD3563.2070400@xenomai.org>
Date: Sun, 16 Dec 2012 03:43:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rMVEY5_Ris9_HGPpsUFht-CdvPdWhPm7jtJ4qfZoyVjKw@mail.gmail.com>	<50CC65AF.6040102@xenomai.org>
	<CAPpP=rPn8k2LTwrYQ_XkKE4vaiazfREnfCJEE5nbY0iD7Apofw@mail.gmail.com>
In-Reply-To: <CAPpP=rPn8k2LTwrYQ_XkKE4vaiazfREnfCJEE5nbY0iD7Apofw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM - Dynamic linking of device
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 12/16/2012 03:01 AM, alex alex wrote:

> Infact, I wonder if it is possible with RTDM to add devices after the
> module is loaded.
> My module is used by programs that do not allow me to know in advance
> how many device linked to the module there will be and what will be
> their name.
> With "rtdm_dev_register" I have to declare statically a fixed number of
> device with a fixed name for each so I wonder if there is a dynamic way
> to add device after the module loading.




I do not understand what prevents you from calling rtdm_dev_register
with dynamic parameters... Again, please post the code which does not
work to help us understand what your problem is.

-- 
                                                                Gilles.

