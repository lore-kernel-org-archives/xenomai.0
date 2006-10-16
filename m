Message-ID: <20061016153937.54204.qmail@domain.hid>
Date: Mon, 16 Oct 2006 08:39:37 -0700 (PDT)
From: mani bhatti <imranbashirbhatti@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1652324942-1161013177=:54134"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Problem with rt_queue
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

--0-1652324942-1161013177=:54134
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all
I am trying to broadcast a message to a queue  from a producer by using function 

rt_queue_send(&queue_input, msg,sizeof(TInputData), Q_BROADCAST);

I have two consumers waiting for the data from producer but the problem is producer is not broadcasting actually to all consumers and  at one time if i run both consumers than only one of the consumer receives the data from producer the other consumer receives nothing and remains blank (the consumer which receives data from queue  is not fixed it is arbitrary).If some one has encountered the problem before please advice me in this regard-Thanks all.The producer code is given below

 while(!end){
               rt_task_wait_period();
               void *msg = rt_queue_alloc(&queue_input, sizeof(TInputData));
                if(msg == NULL) {
                        printf("rt_queue_alloc(queue_inout, %d) failed\n",sizeof(TInputData));
                     }
                memcpy(msg, &sendData, sizeof(TInputData));
                int bytesSent = rt_queue_send(&queue_input,msg,sizeof(TInputData), Q_BROADCAST);
                if (bytesSent <= 0) {
                        printf("rt_queue_send(queue_input) failed: %d\n", bytesSent);
                        rt_queue_free(&queue_input, msg);
                }
                sendData.counter++;
        }



 		
---------------------------------
Do you Yahoo!?
 Get on board. You're invited to try the new Yahoo! Mail.
--0-1652324942-1161013177=:54134
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all<br>I am trying to broadcast a message to a queue&nbsp; from a producer by using function <br><br>rt_queue_send(&amp;queue_input, msg,sizeof(TInputData), Q_BROADCAST);<br><br>I have two consumers waiting for the data from producer but the problem is producer is not broadcasting actually to all consumers and&nbsp; at one time if i run both consumers than only one of the consumer receives the data from producer the other consumer receives nothing and remains blank (the consumer which receives data from queue&nbsp; is not fixed it is arbitrary).If some one has encountered the problem before please advice me in this regard-Thanks all.The producer code is given below<br><br>&nbsp;while(!end){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_wait_period();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *msg = rt_queue_alloc(&amp;queue_input,
 sizeof(TInputData));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(msg == NULL) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("rt_queue_alloc(queue_inout, %d) failed\n",sizeof(TInputData));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(msg, &amp;sendData, sizeof(TInputData));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int bytesSent = rt_queue_send(&amp;queue_input,msg,sizeof(TInputData), Q_BROADCAST);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bytesSent &lt;= 0)
 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("rt_queue_send(queue_input) failed: %d\n", bytesSent);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_queue_free(&amp;queue_input, msg);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sendData.counter++;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br><br><p>&#32;
		<hr size=1>Do you Yahoo!?<br> 
Get on board. <a href="http://us.rd.yahoo.com/evt=40791/*http://advision.webevents.yahoo.com/mailbeta">You're invited</a> to try the new Yahoo! Mail.
--0-1652324942-1161013177=:54134--

