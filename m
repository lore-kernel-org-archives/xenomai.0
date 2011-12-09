Message-ID: <4EE27819.4050000@domain.hid>
Date: Fri, 09 Dec 2011 22:05:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4EE1C949.2030404@domain.hid>
In-Reply-To: <4EE1C949.2030404@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Novice - help needed
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Damir Anicic <Damir.Anicic@domain.hid>
Cc: xenomai@xenomai.org

On 12/09/2011 09:39 AM, Damir Anicic wrote:
> Hi!
> 
> (Sorry for a long mail)
> 
> This is my first xenomai instalation.
> 
> Xenomai 2.6.0
> linux kernel 2.6.38.8
> on Ubuntu 11.10
> on (normal) desktop intel PC ( Core(TM)2 Duo CPU )
> 
> All compiled and booted (it does boot xemonai-kernel):

If your compiler is gcc 4.6, please make sure to pass
-fno-omit-frame-pointers
in the CFLAGS


-- 
                                                                Gilles.

