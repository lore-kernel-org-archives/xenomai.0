Message-ID: <4F70BAE2.5070207@domain.hid>
Date: Mon, 26 Mar 2012 20:52:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+fRa6eqDGrM+ftg2Su_+zGtLsvrnFnCm-HQ5C5HaTQ76y7aCg@domain.hid>
In-Reply-To: <CA+fRa6eqDGrM+ftg2Su_+zGtLsvrnFnCm-HQ5C5HaTQ76y7aCg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] error with rt_pipe
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: daniele.gottfried@domain.hid
Cc: xenomai@xenomai.org, Daniele <danielegottfried@domain.hid>

On 03/26/2012 08:11 PM, Daniele wrote:
> Hi
> I have these errors when I'm trying to make an example of pipe

rt_pipes are deprecated, see xddp sockets examples in
examples/rtdm/profiles/ipc/xddp*

-- 
                                                                Gilles.

