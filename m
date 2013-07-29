MIME-Version: 1.0
Date: Mon, 29 Jul 2013 10:53:18 -0500
Message-ID: <CAH9k9C8OCRic+uuHsdwsJsnR8fhsB=EA=H=dDW=HCpwvMyUPDA@mail.gmail.com>
From: =?UTF-8?Q?Ricardo_Am=C3=A9zquita?= <ramezquitao@cihologramas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Question about queues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm trying to use queues to transfer information between a RT process and
an user-space process.
As far as I understand, I should create a queue using rt_queue_create to
use it latter, but I don see this line in the msg_queue.c example. Is this
example correct?

my rt program right now is something like:

...
rt_queue_create(&motion_q,"Motion",1024*(sizeof(sd_points)+sizeof(amd_times=
)),
                    1024,Q_FIFO);

while(1)
{
...
wait for data
....

rt_queue_write(&monitor_q,&mon_data,sizeof(mon_data),Q_NORMAL);

}


and my user space program is something like


while(1)
{

}

--=20
Ricardo Am=C3=A9zquita O

Combusti=C3=B3n Ingenieros Ltda
Cll 25B # 85B - 76, Bogot=C3=A1 / Colombia
Tel: 57-1-2635232
Fax: 57-1-4296516
http://www.cihologramas.com
