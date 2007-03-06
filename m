Message-ID: <45EDAD18.9080701@domain.hid>
Date: Tue, 06 Mar 2007 19:04:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] process memory not locked
References: <38b44d590703060949lfa70769na93c19abd2ff248f@domain.hid>
	<45EDAB66.9070700@domain.hid>
In-Reply-To: <45EDAB66.9070700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Saiful Khan <saiful.etc@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
>>2. What to do so that the thread also run in highest priority?
> 
> 
> Use pthread_attr_setschedparam, or pthread_setschedparam.
> 

Start here and follow the links:

http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__posix__sched.html

-- 
                                                 Gilles Chanteperdrix

