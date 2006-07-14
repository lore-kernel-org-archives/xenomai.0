Message-ID: <e325d110607141129w4d9142a9j6fa688362faf39e2@domain.hid>
Date: Fri, 14 Jul 2006 19:29:55 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Real time process design issues..
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

Hi all,

I have a simulation program which is using some c++ opensource library
(eg. OpenTissue http://www.opentissue.org/media.php and mimas
http://vision.eng.shu.ac.uk/mediawiki/index.php/Mimas) running in
linux machine. I would like to feed some Real Time informations from
my external microcontroller board which has serial port and USB
interface, to the simulation program running in linux. The simulation
program need to be informed everytime the information received by
linux machine from microcontroller board.

My question is..
Can i create c++ objects in xenomai real time task?
e.g.
void read_task_proc(void *arg)
{
  //create c++ object here..
}
int main(){
    /* create read_task */
    ret = rt_task_create(&read_task,"read_task",0,51,0);
    rt_task_start(&read_task,&read_task_proc,NULL);
}

if i am not allowed to do like the example aboved, what is the best
way of feeding data into my simulation process?

Regards,
Kim Chuan.

