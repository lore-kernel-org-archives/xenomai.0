Message-ID: <18326.22301.47059.975010@domain.hid>
Date: Tue, 22 Jan 2008 21:50:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <f970a6d60801100313t58c8132ehda98e790ff5f5f42@domain.hid>
References: <f970a6d60801100313t58c8132ehda98e790ff5f5f42@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Questions about Xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jose Augusto Matos Santos <jamsjr@domain.hid>
Cc: xenomai@xenomai.org

Jose Augusto Matos Santos wrote:
 > Hi,
 > 
 > I would like to understand Xenomai's scheduler and it will be a pleasure if
 > you recomend me something to read.

There are two things you can read:
- the source, yes, sorry, but this is the best documentation; fortunately,
  Xenomai scheduler is way much simpler than, for instance, Linux
  scheduler. Look particularly in ksrc/nucleus/pod.c for the functions:
  . xnpod_suspend_thread
  . xnpod_resume_thread
  . xnpod_renice_thread
  and, of course xnpod_schedule
- xenomai nucleus module documentation, you will find documentation for
  Xenomai nucleus services, whether related to the scheduler or not:
 http://www.xenomai.org/documentation/trunk/html/api/group__nucleus.html

 > And I want to know if there is any pattern
 > to write Xenomai's api.

I guess by Xenomai's API, you mean Xenomai skin. Yes, there is a
document:
http://www.rtai.dk/cgi-bin/gratiswiki.pl?How_To_Implement_A_New_Skin
I find it on rthe RTAI wiki, but not on Xenomai wiki, maybe we should
copy it here ?

But, the best documentation is to look at other skins. You can look at
the psos+ skin for instance.

-- 


					    Gilles Chanteperdrix.

