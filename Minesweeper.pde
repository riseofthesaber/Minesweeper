

import de.bezier.guido.*;
int NUM_ROWS = 20;
int NUM_COLS = 20;
boolean lose = false;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs= new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 500);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row=0; row<NUM_ROWS; row++)
        for(int col=0; col<NUM_COLS; col++)
            buttons[row][col]= new MSButton(row,col);
    
    
    setBombs();
}
public void setBombs()
{
    int many=50;
    while(many>0){
        int row =(int)(Math.random()*NUM_ROWS);
        int col =(int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[row][col])){
            bombs.add(buttons[row][col]);
            //System.out.println(row+", "+col);
            many--;
        }
    }
}

public void draw ()
{
    background( 0 );
    if(lose)
        displayLosingMessage();
    else if(isWon())
        displayWinningMessage();

}
public boolean isWon()
{
    //your code here
     for(int r=0; r<NUM_ROWS; r++)
            for(int c=0; c<NUM_COLS; c++)
                if(buttons[r][c].isValid(r,c))
                    if(!buttons[r][c].isMarked()&&!buttons[r][c].isClicked())
                        return false;
    return true;
}
public void displayLosingMessage()
{
    //your code here
    stroke(255, 0, 0);
    fill(255, 0, 0);
    text("DED",200,450);
}
public void displayWinningMessage()
{
    //your code here
    fill(255, 0, 255);
    text("A WINNER IS YOU",200,450);

}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {

        
        clicked = true;
        if(marked==true){
            marked=false;
            clicked=false;
        }

        if(mouseButton==RIGHT){
            marked=true;
            clicked=false;

        }else if(bombs.contains(this)){
                lose=true;
        }else if(countBombs(r,c)>0){
            label=""+countBombs(r,c);
        }else{
            if(isValid(r-1,c)&&buttons[r-1][c].clicked==false){ 
                buttons[r-1][c].mousePressed(); 
            }
            if(isValid(r+1,c)&&buttons[r+1][c].clicked==false){
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r,c-1)&&buttons[r][c-1].clicked==false){
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r,c+1)&&buttons[r][c+1].clicked==false){
                buttons[r][c+1].mousePressed();
            }
        }

        //your code here

    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r<NUM_ROWS&&c<NUM_COLS&&r>=0&&c>=0)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        for(int r=row-1; r<=row+1; r++){
            for(int c=col-1; c<=col+1; c++){
                if(isValid(r,c) && bombs.contains(buttons[r][c]))
                    numBombs++;
            }
        }
        //System.out.print(numBombs);
        return numBombs;
    }
}



