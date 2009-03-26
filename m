Message-ID: <49CBBD4B.7070800@domain.hid>
Date: Thu, 26 Mar 2009 18:37:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49CBB6C5.5000407@domain.hid>
In-Reply-To: <49CBB6C5.5000407@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Keyboard IRQ
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antoine Nourry <nourry@domain.hid>
Cc: xenomai@xenomai.org

Antoine Nourry wrote:
> Hi,
> i need to catch a key press as soon as it is released. What is the best 
> solution ?
> I tried to catch keyboard irq (#1) but failed. The ISR doesn't seem to 
> launch...
> 
> I made an RTDM driver successfully (with USB4RT) but never managed to do 
> that simple thing...

I do not understand your mail. If you use an USB keyboard, then it will
certainly not trigger the IRQ 1.

And given the precision of your question, all we can answer is that you
should read the RTDM driver API documentation.

See:
http://www.catb.org/~esr/faqs/smart-questions.html

-- 
                                                 Gilles.

