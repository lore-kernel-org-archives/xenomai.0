MIME-Version: 1.0
Date: Mon, 29 Jul 2013 11:15:08 -0500
Message-ID: <CAH9k9C9QCQuUMgOjgSiVPuVvdaz8zPzbAmLMd+=mAJ5LsC9a9Q@mail.gmail.com>
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

Sorry... I accidentally sent my previous message incomplete. Here there is
the complete message.

I'm trying to use queues to transfer information between a RT process and
an user-space process.
As far as I understand, I should create a queue using rt_queue_create to
use it latter, but I don see this line in the msg_queue.c example. Is this
example correct?

my rt program right now is something like:


...
...
rt_queue_create(&motion_q,"Motion",1024*(sizeof(sd_points)+sizeof(amd_times=
)),
                    1024,Q_FIFO);

while(1)
{
...
wait for data
....

rt_queue_write(&monitor_q,&
mon_data,sizeof(mon_data),Q_NORMAL);

}


and my user space program is something like

....
err =3D rt_queue_bind(&q,"SomeQueueName",TM_INFINITE);
while(1)
{
st=3Drt_queue_receive(&q,&bufp,mode)
}
Am I missing the rt_queue_free and rt_queue_alloc?
Or they are not needed because I'm using the rt_queue_create?


Thanks




--=20
Ricardo Am=C3=A9zquita O

Combusti=C3=B3n Ingenieros Ltda
Cll 25B # 85B - 76, Bogot=C3=A1 / Colombia
Tel: 57-1-2635232
Fax: 57-1-4296516
http://www.cihologramas.com
