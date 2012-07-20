Message-ID: <5009916C.30503@xenomai.org>
Date: Fri, 20 Jul 2012 19:12:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1342263328.84866.YahooMailNeo@web120605.mail.ne1.yahoo.com>
	<500150A5.3080204@xenomai.org>
	<1342416648.20843.YahooMailNeo@web120604.mail.ne1.yahoo.com>
In-Reply-To: <1342416648.20843.YahooMailNeo@web120604.mail.ne1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.0 example run error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jignesh Patel <jigneshj.patel@yahoo.com>
Cc: Xenomai <xenomai@xenomai.org>

On 07/16/2012 07:30 AM, Jignesh Patel wrote:
> yes,i had run "make install"as root...

Ok. So, you have a dynamic /dev and are not using udev? Anyway, what is
needed, as written in the error message, is a character device called
/dev/rtheap with major 10 and minor 254. When using a static /dev, "make
install" takes care of it. When using udev,
ksrc/nucleus/udev/rtheap.rules takes care of it.

Please do not top-post, and do not send private messages.

-- 
                                                                Gilles.

