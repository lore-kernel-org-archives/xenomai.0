MIME-Version: 1.0
Date: Fri, 20 May 2011 15:27:03 +0200
Message-ID: <BANLkTinYewN9P3qLqRwP_XZw0HSaAvRfrw@domain.hid>
From: Hadrien Caron <hadrienstegosaure@domain.hid>
Content-Type: multipart/alternative; boundary=0016364eebb2c9b17104a3b51353
Subject: [Xenomai-help] Meaning of -ENOMEM in rt_pipe_write
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016364eebb2c9b17104a3b51353
Content-Type: text/plain; charset=ISO-8859-1

Hello, I am new to using the Xenomai API and I have a basic question
regarding
the error indicator I just received.

I send large amount of data through pipe using rt_pipe_read and eventually
get a return error of -ENOMEM

On the documentation I saw that :

-ENOMEM is returned if not enough buffer space is available to complete the
operation.

I suppose the buffer refers to the internal buffer of the pipe to which the
data is copied.
I don't understand what I am supposed to do in order to free space on that
buffer so that there
is enough memory.

Could someone give some information about how the buffer is handled ?

Thank you very much in advance.

Regards,

Hadrien Caron

--0016364eebb2c9b17104a3b51353
Content-Type: text/html; charset=ISO-8859-1

Hello, I am new to using the Xenomai API and I have a basic question regarding<br>the error indicator I just received.<br><br>I send large amount of data through pipe using rt_pipe_read and eventually get a return error of -ENOMEM<br>


<br>On the documentation I saw that :<br><br>-ENOMEM is returned if not enough buffer space is available to complete the operation.<br><br>I suppose the buffer refers to the internal buffer of the pipe to which the data is copied.<br>


I don&#39;t understand what I am supposed to do in order to free space on that buffer so that there<br>is enough memory.<br><br>Could someone give some information about how the buffer is handled ?<br><br>Thank you very much in advance.<br>


<br>Regards,<br><font color="#888888"><font color="#888888"><br>Hadrien Caron</font></font>

--0016364eebb2c9b17104a3b51353--

