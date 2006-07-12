From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17588.60439.678980.545437@domain.hid>
Date: Wed, 12 Jul 2006 14:33:27 +0200
Subject: Re: [Xenomai-core] [PATCH] relax context check for rt_task_suspend
In-Reply-To: <44B4EA3B.1010109@domain.hid>
References: <44B4C09F.209@domain.hid>
	<b647ffbd0607120500jccf65cdqd781ff668f2c7ba8@domain.hid>
	<44B4EA3B.1010109@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 >  
 > -	if (xnpod_unblockable_p()) {
 > +	if (xnpod_locked_p()) {

Why not if (task == xeno_current_task() && xnpod_unblockable_p()) ?

-- 


					    Gilles Chanteperdrix.

