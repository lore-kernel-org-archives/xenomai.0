Message-ID: <543F8974.4070400@xenomai.org>
Date: Thu, 16 Oct 2014 11:01:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABaOOZ2YOda_cUS-tskNxDZ6sNekMqnPnbu6p8Qp4kvjRzDMyA@mail.gmail.com>	<543E9BAE.2010808@xenomai.org>	<543E9CF5.6080400@xenomai.org>
 <CABaOOZ1Hb5YYBXt2jtyTZWVnA03EGohaVChzEJ0X9=od2=SeNw@mail.gmail.com>
In-Reply-To: <CABaOOZ1Hb5YYBXt2jtyTZWVnA03EGohaVChzEJ0X9=od2=SeNw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Manual context switch from userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stratiyenko Roman <picoworm@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/16/2014 10:49 AM, Stratiyenko Roman wrote:
> Thank you, I will try longjump() instead of context switch.

If longjmp is in fact siglongjmp, then it will make a system call to 
set the signal mask.

The documentation says:
       longjmp()  and  siglongjmp() make programs hard to understand and main‐
       tain.  If possible an alternative should be used.

What is wrong with using plain threads? Did you observe bad 
performances? On what platform?

-- 
                                                                Gilles.

