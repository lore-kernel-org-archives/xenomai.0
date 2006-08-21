Message-ID: <75975c320608211311qb8e34dj42ef62c0e87a99a8@domain.hid>
Date: Mon, 21 Aug 2006 16:11:47 -0400
From: "Paul Ianna" <paulianna2002@domain.hid>
In-Reply-To: <75975c320608211237m376b5f8w1293c606a2f3699c@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <75975c320608211237m376b5f8w1293c606a2f3699c@domain.hid>
Subject: [Xenomai-help] queue protection
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

Hi All,

I think I know the answer but I wanted to hear from the expert(s) just
to error on the side of caution.

(Speaking from a native API perspective) If I have a single rt_queue
and several rt_tasks (of varying priority and/or periodicity,
asynchronicity) that want to send to that queue, do I need to have
explicit mutual exclusion protection on the queue for send operations,
etc.?

Thanks in advance,
Paul Ianna

