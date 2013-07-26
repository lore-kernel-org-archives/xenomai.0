MIME-Version: 1.0
Date: Fri, 26 Jul 2013 14:28:27 -0500
Message-ID: <CAH9k9C-uqb3Y2j9UzGdKv-p67X2Vz11yiidb_oYuB5MiQ0y03A@mail.gmail.com>
From: =?UTF-8?Q?Ricardo_Am=C3=A9zquita?= <ramezquitao@cihologramas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Queue issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello All

I'm writing a simple wrapper in python to be able to control some real-time
processes. To communicate between the real-time process, and the python
process I'm using native queues. Sending messages from the python process
to the realtime process is working fine, but when I try to send a message
from the realtime process to the python process, I'm having problems. Using
rt_queue inquire, I know that the message is in the queue, but the receive
function in the python side, never receives it.

Is there a limitation that apply to my application? I have tested with
pipes, and it works, but I want to implement everything using queues.

Thanks

--=20
Ricardo Am=C3=A9zquita O

Combusti=C3=B3n Ingenieros Ltda
Cll 25B # 85B - 76, Bogot=C3=A1 / Colombia
Tel: 57-1-2635232
Fax: 57-1-4296516
http://www.cihologramas.com
