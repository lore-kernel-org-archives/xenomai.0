From: Johann Obermayr <johann.obermayr@sigmatek.at>
Date: Fri, 12 May 2017 08:49:48 +0000
Message-ID: <AM4PR0801MB1587EE72522CAA0D6223DA88F5E20@AM4PR0801MB1587.eurprd08.prod.outlook.com>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] missing hook callback for task switching after gatekeeper
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

Kernel: 3.10.53 ARM
Xenomai: 2.6.4

We have a own tool to make task switching, IRQ, TracePoints, ... visible. (=
TracePoint is a single marker in our tool )
So we have a hook in the Linux scheduler and we are using rt_task_add_hook(=
T_HOOK_SWITCH, taskSwitchXenomai)
So we can see all linux / xenomai task switching.
But we are missing one xenomai callback.

We don't see the task switch , that gatekeeper have switch to xenomai, whil=
e gatekepper is running.

L-Usertask          UserTask in second domain
X-Usertask         UserTask in primary domain

Now we see follow

L-Usertask is running and call a function to switch to primary domain.
taskSwitchLinux( L-UserTask -> L-gatekeeper )
L-gatekeeper is running
------ >>> missing taskSwitchXenomai( xnthread_t *curr )             curr =
=3D UserTask in primary domain
Now we see, a TracePoint from the L-Usertask
taskSwitchXenomai( xnthread_t *curr ) curr =3D gatekeeper task
taskSwitchLinux( L-gatekeeper -> L-UserTask)

L-UserTask description
UserFunktion
{
                TracePointMake()
                switchToSecondDomain();
                do_something(30us)
                switchToPromariyDomain();
}

L-UserTask
  While(1)
  {
    For(I =3D 0; I < 10; i++)
       UserFunction();
    Usleep(1000)
  }

I hope it is understandable.

Best regards
  Johann
