MIME-Version: 1.0
Date: Fri, 22 Jun 2012 03:57:01 +0200
Message-ID: <CAHyVJyz4B9Z1nCLEg3G9u-r5d5iHdGwiA78w_enRc--MuVrgMQ@mail.gmail.com>
From: Mohit Jandwani <mohitjandwani@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Xenomai RT user application- POSIX interface
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello I am trying to develop a real time Ethercat master on xenomai on an
exynos board.While I am still stuck with installing xenomai(and plan to
give it all next week), I have run into some problems which I  have not
been able to find on the website anywhere.

I am trying to use the posix skin of xenomai(as I need the stdio functions
and socket functions) simply because of portability and the fact that I
don't have to install it(I can build it while building the kernel).What I
want to ask is:
If I use the sockets in posix skin , does that still guarantee real-time ?
Why is the socket interface not listed in the Posix API pdf ?
 If my code is still real-time does that means I can do file handling in
real time too?(because I can use local protocol family for reading files
through sockets)


Also I tried using the pthread file in the posix skin folder, I was unable
to include the functions
.Everytime I used pthread_mutex_init it gave me a implicit declaration of
function error
.I even tried using #include "posix/pthread" but it didn't work although my
eclipse clearly shows that the header file has been included.
(PS: I can include almost all other header files including the
posix/socket.h  without a problem).
Is this a bug? or am I doing something wrong?

-- 
Mohit Kumar
Third Year Student
Indian Institute of Technology,Delhi

He who can no longer pause to wonder and stand rapt in awe, is as good as
dead; his eyes are closed.
Albert Einstein
