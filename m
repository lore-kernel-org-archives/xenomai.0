Message-ID: <4E358E86.7060808@domain.hid>
Date: Sun, 31 Jul 2011 19:19:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1311873701.2537.YahooMailClassic@domain.hid>
In-Reply-To: <1311873701.2537.YahooMailClassic@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] clock problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philip Ha <philwman@domain.hid>
Cc: xenomai@xenomai.org

On 07/28/2011 07:21 PM, Philip Ha wrote:
> 
> Hi Gilles,
> 
> The following is some part of the code. It is receiving data at a period of
> 1 second intervals. The variable "lat" prints similar latency values for
> the current session, even though I stop the program and start again several
> times. The latency values change everytime I reboot the PC. Please
> advise.

I do not understand:
- how the "latency" may be 40us while it should be around 1s, if you say
that the periodic event happens every second;
- whether you are compiling for the native skin or posix skin, could you
show us the compilation arguments you pass?
- on what platform you get this issue?

-- 
                                                                Gilles.

