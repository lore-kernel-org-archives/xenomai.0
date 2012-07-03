Message-ID: <4FF3240B.3090401@xenomai.org>
Date: Tue, 03 Jul 2012 18:55:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHue_TXhjY-74oUNzuuS=ygCEhcVFeiAB+4ZesjKX19B9WobaA@mail.gmail.com>	<4FCDFB35.1050705@xenomai.org>	<CAHue_TUB-6nufH_O-PRojDPVfpDom+DCv1-_ERV4-xOfEzu2Dg@mail.gmail.com>	<4FCE28F8.9040001@xenomai.org>	<CAHue_TW1ntMpOxwACiawgtm67nYq_e7i11CDxz=CfpGGwRes_A@mail.gmail.com>	<4FD8F4B5.7000001@xenomai.org>	<CAHue_TXMiLTxiK2ZORVccov2wqd+ML-H0zwhLoDYh+7+8_56xw@mail.gmail.com>	<4FE46F5F.1060500@xenomai.org>	<CAHue_TX3UmeMbu9mU_YSKdHeN8oUYFhaeA=mUGgpvJzjnaEdxw@mail.gmail.com>	<4FEB242B.5080306@xenomai.org>	<CAHue_TXXqYsod32WGRzgC9wsnuKkVWX=4vyA9oEi9c_rP276qQ@mail.gmail.com>	<4FEB324B.7020800@xenomai.org>
	<CAHue_TUVeQaxd4hUbT4ok6xprD9WHnj5qw9hcp-W6WK2ZcSwxQ@mail.gmail.com>
In-Reply-To: <CAHue_TUVeQaxd4hUbT4ok6xprD9WHnj5qw9hcp-W6WK2ZcSwxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] unsupported ARM9 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?TWFyY2luIEt1xZtrYQ==?= <marckuska@gmail.com>
Cc: xenomai@xenomai.org

On 07/03/2012 06:49 PM, Marcin Kuśka wrote:
> All I did was applying standard adeos-3.0.13-arm-1.18-09.patch to kernel
> ipipe core-3.2 from your repository and used xenomai upgraded to head
> branch as you suggested.

No, you have to either use adeos-3.0.13 patch with a 3.0 kernel, or use
the ipipe core-3.2 patch with no further patch. You can not mix the two.

-- 
					    Gilles.

