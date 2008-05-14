From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18475.12268.192581.316526@domain.hid>
Date: Wed, 14 May 2008 20:31:08 +0200
In-Reply-To: <37a50be5e303037c147613f6a84341e0@domain.hid>
References: <2ded5d53ed3cbdff58cf25d2523b701f@domain.hid>
	<37a50be5e303037c147613f6a84341e0@domain.hid>
Subject: Re: [Xenomai-help]
 =?utf-8?q?VxWorks_skin_problem_concerning_WIND=5FT?=
 =?utf-8?q?CBstructure?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

Matthie wrote:
> I still don't have any solution to emulate the fields above listed as I
> don't know if I can use Linux posix services ?

Yes, you can use Linux posix services, but they will cause any Xenomai
thread to switch from primary mode to secondary mode.

If you do not understand what I am talking about, you should probably
read the articles at:
http://www.xenomai.org/index.php/Publications

-- 


					    Gilles.

