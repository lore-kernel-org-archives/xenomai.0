Message-ID: <4486CCDF.2070409@domain.hid>
Date: Wed, 07 Jun 2006 14:55:59 +0200
From: Lionel Perrin <perrin@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] shm_open, ftruncate
References: <4480595D.7040203@domain.hid>	<17536.29324.723709.385494@domain.hid>	<4484365A.7090007@domain.hid>	<17540.21517.871383.751462@domain.hid>	<44856CA7.30802@domain.hid>	<17541.29542.312486.329018@domain.hid>	<44859C28.3090600@domain.hid>
	<17541.49945.431732.834139@domain.hid>
In-Reply-To: <17541.49945.431732.834139@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: xenomai@xenomai.org


> I can confirm that a few fixes in v2.1 were missing, so trunk works
> correctly, didn't you forget to rebuild the kernel when building trunk ?
> Attached is a patch to v2.1 that contain the fixes backported from
> trunk. Please try this patch and tell me if this works for you.
>   
In fact, I've downloaded the last version of trunk before your mail and 
the patch. You're right that works pretty good with this version... :)

Unfortunately, it seem's that we can't share between a real time process 
and a non real one ?
I got one task which need to be real time in order to acquire datas, and 
another one that plot this datas on screen.
I'd like to give user the choice to launch (or not) the second process, 
if he wish (or not) to watch the acquired datas. I'm figure out that 
making this second process a xenomai thread with a low priority would 
solve my problem but i'd rather prefered a standard linux process...

