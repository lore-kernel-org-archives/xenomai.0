Message-ID: <4E1AD8DD.3060904@domain.hid>
Date: Mon, 11 Jul 2011 13:05:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALiYb9uRfYeG4NTV7Oy1bMpxtJz0skKsxM9D2k_G5uOZsWWQBQ@mail.gmail.com>
In-Reply-To: <CALiYb9uRfYeG4NTV7Oy1bMpxtJz0skKsxM9D2k_G5uOZsWWQBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with gdb and rt_task_delete
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrien LEMAITRE <adrien.lemaitre@domain.hid>
Cc: xenomai@xenomai.org

On 07/11/2011 11:50 AM, Adrien LEMAITRE wrote:
> Hello,
> 
> I have two problems. Just before explain my problems i would like to clarify
> the context. This exercice is for student. In this exercice, they program a
> WorkingTask (infini loop)

That is the problem, there should not busy inifinite loops.
rt_task_sleep(100) asks for 100ns sleep, which is equivalent to not
sleeping at all.

I seem to remember that I already told you this in answer to your
previous post.

-- 
                                                                Gilles.

