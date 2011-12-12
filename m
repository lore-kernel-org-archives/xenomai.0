Message-ID: <4EE5EA68.7060804@domain.hid>
Date: Mon, 12 Dec 2011 12:50:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4EE5E9B1.6040900@domain.hid>
In-Reply-To: <4EE5E9B1.6040900@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to get librtdk.so built
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

On 12/12/2011 12:46 PM, Damir Anicic wrote:
> Hi!
> 
> I am missing librtdk.so.
> Which option, and where, kernel or xenomai,
> do I have to enable to get librtdk.so built?

rtdk is no longer a separate library, it is included in libxenomai,
which is linked by default, whatever skin you use.

-- 
                                                                Gilles.

