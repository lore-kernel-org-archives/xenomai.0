Message-ID: <450157A6.80000@domain.hid>
Date: Fri, 08 Sep 2006 13:44:38 +0200
From: Dirk Eibach <eibach@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Resource leaking problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hello,

we have lots of tasks, semaphores and mutexes in our complex 
application. Stopping and restarting seems to leak some resources, 
because we get ENOMEM when a thread is created after restarting the 
application, first time everything goes well.

Probably we do something wrong, maybe somebody can tell us what.

What do we have to do in order to clean up all resources properly, 
especially if our application is ended by SIGKILL?

Cheers.
-- 
Dirk Eibach <eibach@domain.hid>
Guntermann & Drunck Systementwicklung GmbH
F & E
Dortmunder Str. 4a, D-57234 Wilnsdorf
Tel.: +49 (0) 2739 8901 100, Fax.: +49 (0) 2739 8901 120




