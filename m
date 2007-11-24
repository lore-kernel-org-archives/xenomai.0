MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18248.10152.271616.447058@domain.hid>
Date: Sat, 24 Nov 2007 14:31:20 +0100
In-Reply-To: <fd6a47a90711240524o2565a833g943d9382a5b7be76@domain.hid>
References: <fd6a47a90711240524o2565a833g943d9382a5b7be76@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Waiting for a terminating RTDM thread in
	module_exit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Jeroen Van den Keybus wrote:
 > So, in short, how do I wait in the module_exit ?

rtdm_task_join_nrt

http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__rtdmtask.html#g96a5791aacc2ee904ae590a3efc43c1b

-- 


					    Gilles Chanteperdrix.

