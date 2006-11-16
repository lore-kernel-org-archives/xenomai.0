Message-ID: <455C3A92.3030402@domain.hid>
Date: Thu, 16 Nov 2006 11:16:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] License question: xenomai is LGPL but GPL in
	headers
References: <21504966.1163669346422.JavaMail.ngmail@domain.hid>
In-Reply-To: <21504966.1163669346422.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

M. Koehrer wrote:
> Hi everybody,
> 
> I have a copyright question concerning Xenomai:
> As far as I understand it, Xenomai in user space is licensed under the LGPL
> which means that I may link any commercial application against it.
> My question is now: 
> Even in a user space application I have to include some xenomai headers
> like <native/task.h>
> When I look into native/task.h I see there the GPL copyright statement and not
> the LGLP.
> My question is now:
> When I include the Xenomai headers in a user space application, does my
> user space application fall automatically under the GPL or is it still possible
> to build a commercial application?
> 
> I am not a lawyer, however sometime I think each software developer should be a lawyer..

Look at include/COPYING: there is an exception for headers.

-- 
                                                 Gilles Chanteperdrix

