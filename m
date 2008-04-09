MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18428.55929.679856.767053@domain.hid>
Date: Wed, 9 Apr 2008 17:02:17 +0200
In-Reply-To: <8c12bab70803250638y36c67e0cx6d52aa4a85979720@domain.hid>
References: <8c12bab70803250638y36c67e0cx6d52aa4a85979720@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Beginner Help
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: a.iqbal@domain.hid
Cc: xenomai@xenomai.org

Asif Iqbal wrote:
 > Hello
 > 
 > I just installed Xenomai on 2.6.24 kernel and played with some examples from
 > the cvs repository. I can create a 10 KHz hard real-time loop in an
 > amazingly simple way *rt_task_set_periodic.* There is a certain jitter that
 > can occasionally go as high as 50us(!) but I have not had any overruns.
 > 
 > Now I would like to do the following:
 > 
 > 1) Read data from serial port that is coming from a microcontroller board.
 > 2) Filter this data using a simple low-pass filter
 > 3) Share the results through a webserver  (Apache) at a much lower frequency
 > @ ca. 1 Hz.
 > 
 > Could you point me to some example source code that resembles my needs, esp.
 > step 3?

I am afraid your question is a bit off-topic on this list. Publishing
results through a webserver is not an issue that I face frequently, and
I guess this is the case for many people on this list.

-- 


					    Gilles.

