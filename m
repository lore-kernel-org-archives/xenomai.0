Message-ID: <4417C3D8.10801@domain.hid>
Date: Wed, 15 Mar 2006 08:35:52 +0100
From: marcellin <marcellin.fotze@domain.hid>
Subject: Re: [Xenomai-help] the same error-solution
References: <4416CC6A.8030605@domain.hid>	<17430.53111.874553.840320@domain.hid>	<4416D650.3040609@domain.hid>
	<17430.59156.719375.430724@domain.hid>
In-Reply-To: <17430.59156.719375.430724@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi ,

Now it works fine, in fact there was two mistakes :

-I've forgot to link with librtdm (-lrtsm)

-I've forgot rt_task_shadow() in the main Linux thread

thanks everybody.

Best regards

Marcell1

