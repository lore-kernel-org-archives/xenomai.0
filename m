Message-ID: <4876F7CC.6010808@domain.hid>
Date: Fri, 11 Jul 2008 08:03:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4876C37B.70205@domain.hid>
In-Reply-To: <4876C37B.70205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] use of RTAI-Lab or equivalent,
 with Scicos and Comedi
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guillaume Millet <millet@domain.hid>
Cc: xenomai@xenomai.org

Guillaume Millet wrote:
> Hello,
> 
> is there a project similar to RTAI-Lab 
> (https://www.rtai.org/index.php?module=pagemaster&PAGE_user_op=view_page&PAGE_id=8&MMN_position=23:23, 
> tutorial on https://www.rtai.org/RTAILAB/RTAI-Lab-tutorial.pdf) with 
> block diagrams for Scicos and acquisition devices supported by Comedi ?
> I know the existence of Comedi over RTDM, but I haven't seen Xenomai 
> blocks for Scicos. Could RTAI-Lab be used with Xenomai ? Sorry if my 
> question is stupid, I am a newbie in real-time development.

No, rtai-lab has not been ported to Xenomai, but this should be
certainly doable, since I have heard of at least one project which
generates code for Xenomai with Matlab/Simulink (and without rtai-lab).

-- 


					    Gilles.

