Message-ID: <8c12bab70803250638y36c67e0cx6d52aa4a85979720@domain.hid>
Date: Tue, 25 Mar 2008 14:38:00 +0100
From: "Asif Iqbal" <a.iqbal@domain.hid>
Sender: aiqbalrana@domain.hid
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16683_30911043.1206452280110"
Subject: [Xenomai-help] Beginner Help
Reply-To: a.iqbal@domain.hid
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

------=_Part_16683_30911043.1206452280110
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello

I just installed Xenomai on 2.6.24 kernel and played with some examples from
the cvs repository. I can create a 10 KHz hard real-time loop in an
amazingly simple way *rt_task_set_periodic.* There is a certain jitter that
can occasionally go as high as 50us(!) but I have not had any overruns.

Now I would like to do the following:

1) Read data from serial port that is coming from a microcontroller board.
2) Filter this data using a simple low-pass filter
3) Share the results through a webserver  (Apache) at a much lower frequency
@ ca. 1 Hz.

Could you point me to some example source code that resembles my needs, esp.
step 3?

Thank you.

Asif

------=_Part_16683_30911043.1206452280110
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello<br><br>I just installed Xenomai on 2.6.24 kernel and played with some examples from the cvs repository. I can create a 10 KHz hard real-time loop in an amazingly simple way <b>rt_task_set_periodic.</b> There is a certain jitter that can occasionally go as high as 50us(!) but I have not had any overruns. <br>
<br>Now I would like to do the following:<br><br>1) Read data from serial port that is coming from a microcontroller board.<br>2) Filter this data using a simple low-pass filter<br>3) Share the results through a webserver&nbsp; (Apache) at a much lower frequency @ ca. 1 Hz.<br>
<br>Could you point me to some example source code that resembles my needs, esp. step 3?<br><br>Thank you.<br><br>Asif<br>

------=_Part_16683_30911043.1206452280110--

