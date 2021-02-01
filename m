From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: several questions about porting latmus
Date: Mon, 1 Feb 2021 04:36:29 +0000
Message-ID: <MWHPR11MB1710FDC8D365CE3FCFADA88DF2B69@MWHPR11MB1710.namprd11.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

Hi Philippe

When I was trying to port latmus from evl to xenomai 3.2,  I met several is=
sues that block porting
and need your suggestions.

1. When I tried to replace function evl_run_kthread_on_cpu of latmus.c driv=
er ,  I found that only rtdm_task_init =20
    can meet our requirements mostly  but we still cannot pass cpu affinity=
 through it to pin task to required
    cpu. Do we need to implement new API so that we can  pass cpu affinity =
to pin task to required cpu but
    finish all functions  of rtdm_task_init?

2. Regarding replacement of evl_get_xbuf of latmus.c,  I would first call=20
     rtdm_socket (AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP); to create socket an=
d then call rtdm_bind  to bind
     it to XDDP_PORT=3Dxfd that passed from user space  after call rtdm_set=
sockopt to do corresponding operation like
      demo/posix/cobalt/xddp-stream.c.
     Of course , I would replace evl_write_xbuf with rtdm_sendto  and corre=
sponding xbuf variable type in related=20
     structure.  In addition , on userspace of latmus , I would  replace ev=
l_create_xbuf with open ("/dev/rtp$xfd ",..) and then
     read by returned handler to get data from socket.  Is such design OK f=
or you?
     Actually , I can not find any instance about rtdm_socket but descripti=
on in doc/asciidoc/MIGRATION.adoc, I do not know
    If such design is feasible. Please comment.


Regards

Hongzhan Chen


