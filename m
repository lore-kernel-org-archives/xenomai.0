Message-ID: <51BEB8BC.5090206@xenomai.org>
Date: Mon, 17 Jun 2013 09:20:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51826EEA.1090202@mitrol.it>	<51830D98.7090309@xenomai.org>	<5183CDD6.80400@mitrol.it>	<518A06C9.50204@mitrol.it>
	<518A4C09.8030906@xenomai.org>	<518A505C.2090207@mitrol.it>
	<518A52A7.5000801@xenomai.org>	<518A5600.20508@mitrol.it>
	<518A6195.7030206@mitrol.it>	<518A77F8.3070404@xenomai.org>
	<518A78DF.7020300@xenomai.org>	<518BA678.9030406@xenomai.org>
	<518BAA18.2090209@mitrol.it> <518BAB98.4030108@xenomai.org>
	<518BACDB.8040203@xenomai.org> <518BADE8.90102@xenomai.org>
	<518C97FB.5010507@mitrol.it>
In-Reply-To: <518C97FB.5010507@mitrol.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Re : Sporadic problem : rt_task_sleep locked after
 debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: xenomai@xenomai.org

On 05/10/2013 08:47 AM, Paolo Minazzi wrote:

> /D # gdbserver :8888 prova
> Process prova created; pid = 295
> Listening on port 8888
> Remote debugging from host 198.18.0.1
> xnpod_delete_thread: deleting dormant shadow demo0
> xnpod_delete_thread: deleting dormant shadow demo1
> xnpod_delete_thread: deleting dormant shadow demo2
> xnpod_delete_thread: deleting dormant shadow demo3
> xnpod_delete_thread: deleting dormant shadow demo4
> xnpod_delete_thread: deleting dormant shadow demo5
> xnpod_delete_thread: deleting dormant shadow demo6
> xnpod_delete_thread: deleting dormant shadow demo7
> xnpod_delete_thread: deleting dormant shadow demo8
> xnpod_delete_thread: deleting dormant shadow demo9
> xnpod_delete_thread: deleting dormant shadow demo10
> xnpod_delete_thread: deleting dormant shadow demo11
> xnpod_delete_thread: deleting dormant shadow demo12

This should fix the issue:
http://git.xenomai.org/?p=xenomai-2.6.git;a=commit;h=b2ddb284c9b7e6cbd6c2a0d26544e9a0a618f32a

> ....
> 
> Paolo
> 
> 


-- 
Philippe.

