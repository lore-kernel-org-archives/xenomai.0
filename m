Message-ID: <4860F3A5.6060706@domain.hid>
Date: Tue, 24 Jun 2008 15:16:21 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <20080624123602.114820@domain.hid>
	<4860ED80.2030400@domain.hid>
	<20080624130059.114820@domain.hid>
In-Reply-To: <20080624130059.114820@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] error creating a task with rt_task_spawn
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: xenomai@xenomai.org

Karl Reichert wrote:
> Yes, you are right. My fault ...
> 
> But after modifying, when I run this program, the computer locks.
> I can move the mouse and even mouve the windows (Xfree), but I can
> neither close the window, click any buttons nor enter anything in
> the terminal-window.
> 
> Any ideas?

Your RT task looks as follows:

> void rx_task(void *cookie)
> {
> 	j=0;
> 	j++;
> 	while(1);
> }

An endless loop in an RT task ... no good idea.

-- 
Sebastian

