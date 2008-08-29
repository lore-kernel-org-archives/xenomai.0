Message-ID: <48B7E96B.1080903@domain.hid>
Date: Fri, 29 Aug 2008 14:19:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid>	<48B55F7C.5030901@domain.hid>	<48B56685.4060500@domain.hid>	<48B570AF.4090900@domain.hid>	<48B57281.2090109@domain.hid>	<48B57626.8070404@domain.hid>	<48B576F2.5010409@domain.hid>	<48B57BE0.8000701@domain.hid>	<48B57D32.60504@domain.hid>	<48B599DD.6070306@domain.hid>	<48B5A4AB.3030909@domain.hid>	<48B5B9FC.2050900@domain.hid>	<48B5D8EC.90009@domain.hid>	<48B6776E.6030502@domain.hid>
	<48B6984B.80804@domain.hid>	<48B79A05.7060203@domain.hid>
	<48B79EAB.8000109@domain.hid>	<48B7A3AF.6010802@domain.hid>
	<48B7A550.2030001@domain.hid> <48B7C31B.1050605@domain.hid>
	<48B7C438.9020000@domain.hid> <48B7D180.3070709@domain.hid>
In-Reply-To: <48B7D180.3070709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH 2/3] Switch to handle-based
 fast	mutex owners
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Probably. But it will definitely need full fast locking support inside
> xnsynch, which is basically about defining and maintaining a generic
> user-shared lock word from within xnsynch services that has at least a
> 'claimed' and a 'assignment pending' bit. Looks like we will not run out
> of work soon... ;)

The way xnsynch_sleep_on checks the owner field and retries for the
implementation of the lock stealing already furiously look like a mutex
compare and exchange...


-- 
                                                 Gilles.

