Date: Wed, 18 Jul 2007 14:43:22 +0000 (GMT)
From: Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-933887694-1184769802=:73250"
Message-ID: <314537.73250.qm@domain.hid>
Subject: [Xenomai-help] Problem with rt_pipe and user space communication
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

--0-933887694-1184769802=:73250
Content-Type: text/plain; charset=ascii

Hi everybody,

I try to learn Xenomai. I have a problem that I do not understand. I want that my real time task to communicate with my user space task through a pipe (FIFO) in order to save sample datas in a file. My problem is the following. I create a pipe with:

err = rt_pipe_create(&pipe1,"MyPipe1",1,FIFO_SIZE_PARAM*sizeof(double));
    if(err)
    {
        printf("pipe MyPipe1 creation failure : %d\n",err);
    }

then in the real time task i write to the pipe like this:

err = rt_pipe_stream(&pipe1,&tension0,sizeof(double)); // i already try rt_pipe_write but i got the same result
        if ( err < 0 ) 
        {
        printf("rt_pipe_write erreur %d \n",err);
        }


On the user side, i am doing the following :

    double tabTest[FIFO_SIZE_PARAM];
    int nb_read;
    nb_read=read(pipe1user,tabTest,FIFO_SIZE_PARAM*sizeof(double));
    printf("I got  %d bytes\n",nb_read);


I get a value of 8 for nb_read which corresponds to sizeof(double). But i am expecting more. I do not know why the system function read(2) works like this.

Thank you in advance for your help,

Mathieu




      _____________________________________________________________________________ 
Ne gardez plus qu'une seule adresse mail ! Copiez vos mails vers Yahoo! Mail 
--0-933887694-1184769802=:73250
Content-Type: text/html; charset=ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman,new york,times,serif;font-size:10pt"><div>Hi everybody,<br><br>I try to learn Xenomai. I have a problem that I do not understand. I want that my real time task to communicate with my user space task through a pipe (FIFO) in order to save sample datas in a file. My problem is the following. I create a pipe with:<br><br>err = rt_pipe_create(&amp;pipe1,"MyPipe1",1,FIFO_SIZE_PARAM*sizeof(double));<br>&nbsp;&nbsp;&nbsp; if(err)<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("pipe MyPipe1 creation failure : %d\n",err);<br>&nbsp;&nbsp;&nbsp; }<br><br>then in the real time task i write to the pipe like this:<br><br>err = rt_pipe_stream(&amp;pipe1,&amp;tension0,sizeof(double)); // i already try rt_pipe_write but i got the same result<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if ( err &lt; 0 ) <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("rt_pipe_write erreur %d \n",err);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br><br><br>On the user side, i am doing the following :<br><br>&nbsp;&nbsp;&nbsp; double tabTest[FIFO_SIZE_PARAM];<br>&nbsp;&nbsp;&nbsp; int nb_read;<br>&nbsp;&nbsp;&nbsp; nb_read=read(pipe1user,tabTest,FIFO_SIZE_PARAM*sizeof(double));<br>&nbsp;&nbsp;&nbsp; printf("I got&nbsp; %d bytes\n",nb_read);<br><br><br>I get a value of 8 for nb_read which corresponds to sizeof(double). But i am expecting more. I do not know why the system function read(2) works like this.<br><br>Thank you in advance for your help,<br><br>Mathieu<br></div></div><br>



      <hr size="1"> 
Ne gardez plus qu'une seule adresse mail ! <a href="http://www.trueswitch.com/yahoo-fr/">Copiez vos mails</a> vers Yahoo! Mail </body></html>
--0-933887694-1184769802=:73250--

